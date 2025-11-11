# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a production-grade Neovim configuration with 80+ plugins, built around lazy.nvim for performance optimization. The architecture uses strict modular separation: plugin specifications, configurations, and keybindings are completely decoupled into separate files that return functions for deferred execution.

**Repository:** https://github.com/NishantJoshi00/nvim-config
**Leader Key:** `<space>`

## Development Commands

### Basic Operations
- **Reload plugin after changes:** `:Lazy reload <plugin-name>`
- **Check plugin health:** `:checkhealth`
- **Analyze startup performance:** `:Lazy profile`
- **Debug Treesitter:** `:TSCaptureUnderCursor`
- **Execute Lua code:** `:LuaToBuffer <code>` (appends output to buffer)
- **View messages:** `:messages`

### Testing Configuration Changes
1. Make changes to plugin config or keybinds
2. Source the file: `:source %` (if in the modified file)
3. Reload plugin: `:Lazy reload <plugin-name>`
4. Verify with `:checkhealth` and test functionality
5. Check for startup errors with `:messages`

## Architecture

### Strict Initialization Order

The configuration follows a critical initialization sequence in `init.lua`:

1. **Bytecode caching** (`vim.loader.enable()`)
2. **Leader key** (must be set BEFORE plugins load)
3. **Theme options** (`theme.lua` - loaded BEFORE plugins for proper UI initialization)
4. **Bootstrap lazy.nvim** (auto-installs if missing)
5. **Load all plugins** (`require("plugins")`)
6. **Post-plugin configuration:**
   - `config.lua` - LSP setup, diagnostics, autocmds
   - `mappings.lua` - loads all keybinding modules
   - `masking.lua` - buffer mutability system
   - `custom/` - platform-specific settings
7. **Auto-update check** (async git fetch, non-blocking)

**Critical:** Theme options MUST load before plugins, and leader key MUST be set before keybindings are registered.

### Plugin System Architecture

**Three-layer modular pattern:**

1. **Specification** (`lua/plugins/init.lua`):
   ```lua
   {
       "author/plugin",
       event = "VeryLazy",
       dependencies = { ... },
       config = require("plugins.config.plugin-name"),
   }
   ```

2. **Configuration** (`lua/plugins/config/plugin-name.lua`):
   ```lua
   return function()
       require("plugin").setup({ ... })
   end
   ```
   - Returns a function for deferred execution
   - Enables lazy loading and error isolation
   - All 41 config files follow this pattern

3. **Keybindings** (`lua/plugins/keybinds/plugin-name.lua`):
   ```lua
   return function()
       vim.keymap.set("n", "<leader>xx", function() ... end, { desc = "..." })
   end
   ```
   - Returns a function loaded by `mappings.lua`
   - 16 separate keybind modules
   - Prevents plugin loading from triggering keybind registration prematurely

**Why this matters:** The function-wrapping pattern ensures plugins can be lazy-loaded without executing their config code until the plugin actually loads. This is critical for startup performance.

### LSP Architecture

Multi-layer LSP setup using mason ecosystem:

1. **mason.nvim** - Installs LSP servers, formatters, linters
2. **mason-lspconfig.nvim** - Bridges Mason to nvim-lspconfig
3. **mason-null-ls.nvim** - Bridges Mason to none-ls (formatters/linters)

**Default handler pattern** in `config.lua`:
```lua
require("mason-lspconfig").setup({
    handlers = {
        function(server_name)  -- Default for all servers
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
            })
        end,
        ["rust_analyzer"] = function() end,  -- Skip (rustaceanvim handles it)
        ["hls"] = function() end,            -- Skip (haskell-tools handles it)
    }
})
```

**Language-specific overrides:**
- **Rust:** rustaceanvim with config in `lua/opts/init.lua`
- **Haskell:** haskell-tools.nvim (filetype trigger)
- **Lua:** lazydev.nvim for Neovim API completion

### Key Module Relationships

**Core dependencies:**
- `utils.lua` - Platform detection (`gated_execute()`, `disabled_on()`)
- `functions.lua` - Shared utilities used by custom keybinds and plugin configs
- `exports.lua` - Color definitions shared by themes and statusline
- `opts/init.lua` - Language-specific LSP configurations

**Keybinding namespace conventions:**
- `<leader>f*` - Find/File operations (Telescope)
- `<leader>g*` - Git operations
- `<leader>m*` - Miscellaneous/Markdown
- `<leader>e*` - Editor operations
- `<c-*>` - Quick actions (format with `<c-s>`, search with `<c-p>`)

### Advanced Features

**Buffer Masking System** (`masking.lua` + `disabler.lua`):
- Toggle ALL buffers between readonly/modifiable
- Serializes and deserializes ALL keybindings to prevent edits
- Keybinds: `<leader><c-d>` (disable all), `<leader><c-a>` (enable all)
- Used for code review mode

**Markdown Tree** (`markdown-tree.lua`):
- Parse markdown checklists into interactive tree
- NUI tree visualization with expand/collapse
- Toggle checkboxes and persist changes back to file

**AI Integration** (`ai/interface.lua`):
- OpenAI API client for intelligent note organization
- Operations: smart append, summarize, reorganize
- Used by markdown-focused keybinds

**Platform-Specific Code** (`custom/os/`):
- `mac.lua` - Neovide fullscreen on macOS
- `windows.lua` - Windows-specific settings
- Loaded via `utils.gated_execute()` for conditional execution

## Adding New Plugins

Follow this exact workflow to maintain architecture:

1. **Add specification** to `lua/plugins/init.lua`:
   ```lua
   {
       "author/plugin-name",
       event = "VeryLazy",  -- or BufReadPre, InsertEnter, etc.
       dependencies = { "required/deps" },
       config = require("plugins.config.plugin-name"),
   }
   ```

2. **Create config file** at `lua/plugins/config/plugin-name.lua`:
   ```lua
   return function()
       local ok, plugin = pcall(require, "plugin-name")
       if not ok then
           vim.notify("Failed to load plugin-name", vim.log.levels.ERROR)
           return
       end

       plugin.setup({
           -- configuration here
       })
   end
   ```

3. **Create keybinds** at `lua/plugins/keybinds/plugin-name.lua`:
   ```lua
   return function()
       local keymap = vim.keymap.set

       keymap("n", "<leader>xx", function()
           -- action
       end, { desc = "Description for which-key" })
   end
   ```

4. **Load keybinds** in `lua/mappings.lua`:
   ```lua
   require("plugins.keybinds.plugin-name")()
   ```

5. **Test:**
   - Restart Neovim or use `:Lazy reload plugin-name`
   - Verify with `:checkhealth`
   - Check startup time impact with `:Lazy profile`

## Critical Patterns

### Protected Calls
Always use pcall for plugin loading to prevent cascade failures:
```lua
local ok, plugin = pcall(require, "plugin")
if not ok then
    vim.notify("Failed to load", vim.log.levels.ERROR)
    return
end
```

### Module-Scoped State
Use Lua closures instead of global variables:
```lua
-- CORRECT: module-scoped
local state = { active = false }

return function()
    state.active = not state.active
end

-- WRONG: global pollution
_G.state = { active = false }
```

### Async Job Handling
UI updates must be scheduled:
```lua
vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data, _)
        vim.schedule(function()
            -- UI updates here
            vim.notify("Done!")
        end)
    end
})
```

### Platform Gating
Use utils for conditional execution:
```lua
require("utils").gate("mac", function()
    -- macOS-specific code
end)

-- Or check platform:
if require("utils").disabled_on("windows") then
    return  -- Skip on Windows
end
```

## File Organization Rules

- **DO NOT** add configuration code to `lua/plugins/init.lua` - keep it only for specifications
- **DO NOT** mix keybindings with plugin config - always separate files
- **DO NOT** use global variables - use module-scoped state or Neovim's `vim.b`/`vim.g` appropriately
- **DO** follow the function-wrapping pattern for all configs and keybinds
- **DO** use descriptive names matching the plugin name (e.g., `nvim-tree.lua`, not `tree.lua`)
- **DO** add descriptions to keymaps for which-key integration

## Performance Considerations

- **Lazy loading strategies:**
  - Use `event = "VeryLazy"` for UI enhancements
  - Use `event = "BufReadPre"` for editing-related features
  - Use `event = "InsertEnter"` for completion
  - Use `ft = "filetype"` for language-specific plugins
  - Use `cmd = "Command"` for command-triggered plugins

- **Priority loading:**
  - Theme should have `priority = 1000`
  - Flatten (for embedded terminals) needs `priority = 1001`

- **Startup optimizations:**
  - Bytecode caching is enabled (`vim.loader.enable()`)
  - Avoid running expensive operations in config functions
  - Use autocommands with specific events, not broad triggers
  - Keep statusline computations cached (see `lualine.lua` for buffer caching pattern)

## Common Pitfalls

1. **Loading order issues:** If keybindings don't work, ensure the plugin is loaded before mappings.lua runs. Check that the config function is actually being called.

2. **Global state pollution:** Avoid `_G` namespace. Use module-local variables or vim's scoped variables (`vim.b`, `vim.w`, `vim.t`, `vim.g`).

3. **Missing pcall:** Always wrap plugin requires in pcall to prevent startup failures from cascading.

4. **UI updates in callbacks:** Async callbacks (jobstart, libuv) must use `vim.schedule()` for UI operations.

5. **Platform assumptions:** Don't assume unix-style paths or commands. Use `utils.disabled_on()` for platform-specific code.

## Debugging Workflow

When something breaks:

1. Check `:messages` for errors
2. Run `:checkhealth` to identify missing dependencies
3. Use `:Lazy profile` to find slow plugins
4. Test plugin in isolation: `:Lazy load plugin-name`
5. Source the config file directly: `:luafile lua/plugins/config/plugin-name.lua`
6. Check if keybind is registered: `:verbose map <leader>xx`
7. For LSP issues: `:LspInfo` and `:LspLog`
8. For Treesitter: `:TSCaptureUnderCursor` and `:InspectTree`
