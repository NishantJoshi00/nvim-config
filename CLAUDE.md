# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration repository built with a modular architecture using lazy.nvim as the plugin manager. The configuration manages 80+ plugins with event-driven loading for optimal performance.

## Critical Architectural Patterns

### Loading Order (init.lua)
The initialization follows a strict sequence that must be preserved:
1. `vim.loader.enable()` - Bytecode caching (Neovim 0.10+)
2. `vim.g.mapleader = " "` - Set leader key BEFORE any plugins
3. `require("theme")` - Load core options BEFORE plugins
4. `require("bootstrap")` - Bootstrap lazy.nvim plugin manager
5. `require("lazy").setup(require("plugins"))` - Load all plugins
6. `require("config")` - Load configuration after plugins
7. `require("mappings")` - Load keybindings
8. `require("masking")` - Load masking utilities
9. `require("custom")` - Load platform-specific configs
10. Auto-update check via `require("functions.up-to-date").check()`

### Plugin Architecture
All plugin specifications are in `lua/plugins/init.lua` with a consistent pattern:
- Plugin config functions live in `lua/plugins/config/<plugin-name>.lua` and return a function
- Plugin keybinds live in `lua/plugins/keybinds/<plugin-name>.lua` and return a function
- Keybinds are loaded explicitly in `lua/mappings.lua` via `require("plugins.keybinds.<name>")()`
- Lazy loading uses `event = "VeryLazy"`, `event = "BufReadPre"`, or filetype triggers (`ft = { ... }`)

### Platform-Specific Code
OS-specific configurations are in `lua/custom/os/` and loaded via `lua/custom/init.lua`. The system uses `vim.fn.has()` to detect the platform.

## Common Development Commands

### Neovim Plugin Management
- `:Lazy` - Open lazy.nvim plugin manager UI
- `:Lazy sync` - Update all plugins
- `:Lazy reload <plugin-name>` - Reload a specific plugin (useful when testing changes)
- `:Lazy profile` - Analyze startup performance and plugin load times
- `:Lazy clean` - Remove unused plugins

### Health Checks & Debugging
- `:checkhealth` - Verify installation and plugin health
- `:TSCaptureUnderCursor` - Debug TreeSitter highlighting under cursor
- `:LuaToBuffer <code>` - Execute Lua code and append output to current buffer (WARNING: executes arbitrary code)

### LSP & Language Tools
- Mason (`:Mason`) manages LSP servers, formatters, and linters
- LSP servers are configured in `lua/plugins/config/mason-lspconfig.lua`
- Language-specific configs for Rust (rustaceanvim), Haskell (haskell-tools.nvim), and Zig (zig.vim)

### Custom Functions (lua/functions.lua)
- `require("functions").point_search()` (Ctrl+P) - Navigate to file:line:col locations
- `require("functions").glob_search()` - Telescope live_grep with glob pattern filtering
- `require("functions").copy_pad(name, callback, init)` - Create scratch pad popups
- `require("functions").theme_choicer()` - Interactive theme selector
- `require("functions").get_current_location(callback)` - Get current file:line:col
- `require("functions").quoter()` - Fetch and display random quote

### Key Binding Strategy
- Leader key: `<space>`
- Consistent namespacing: `<leader>f*` (file/find), `<leader>g*` (git), `<leader>m*` (misc)
- Plugin-specific bindings in isolated `lua/plugins/keybinds/<plugin>.lua` files

## Adding New Plugins

1. Add plugin spec to `lua/plugins/init.lua` with appropriate lazy loading:
   ```lua
   {
       "author/plugin-name",
       event = "VeryLazy",  -- or appropriate trigger
       dependencies = { ... },
       config = require("plugins.config.plugin-name"),
   }
   ```

2. Create config function in `lua/plugins/config/plugin-name.lua`:
   ```lua
   return function()
       require("plugin-name").setup({
           -- config here
       })
   end
   ```

3. Create keybinds in `lua/plugins/keybinds/plugin-name.lua`:
   ```lua
   return function()
       vim.keymap.set("n", "<leader>xx", function() ... end, { desc = "..." })
   end
   ```

4. Add to `lua/mappings.lua`:
   ```lua
   require("plugins.keybinds.plugin-name")()
   ```

5. Test with `:Lazy reload plugin-name`

## Important Configuration Details

### Diagnostics (lua/config.lua)
- Configured with `update_in_insert = true` (Neovim 0.10+)
- Rounded border floats with severity sorting
- Virtual text enabled with "●" prefix

### LSP Capabilities (lua/config.lua)
- Auto-enables inlay hints when LSP supports them (`inlayHintProvider`)
- Semantic tokens enabled for supporting servers (Neovim 0.10+)
- LspAttach autocmd handles per-buffer LSP setup

### Custom Autocmds
- `*.Jenkinsfile` files auto-detected as groovy filetype
- `.mlw` files treated as OCaml

### Build Commands
- Telescope FZF Native: Built with `make` (defined in plugin spec `build = "make"`)
- TreeSitter: Uses `:TSUpdate` for grammar updates

## File Structure Reference

```
lua/
├── bootstrap.lua         # lazy.nvim setup (auto-installs if missing)
├── theme.lua            # Core vim options loaded BEFORE plugins
├── config.lua           # Diagnostics, LSP setup, autocmds, custom commands
├── mappings.lua         # Loads all keybind modules
├── functions.lua        # Utility functions (point_search, copy_pad, etc.)
├── masking.lua          # Masking utilities
├── utils.lua            # Helper functions (gate, is_day, join)
├── plugins/
│   ├── init.lua         # All plugin specifications (80+)
│   ├── config/          # Plugin configuration functions
│   └── keybinds/        # Plugin-specific keybind functions
├── custom/
│   ├── init.lua         # Platform-specific loader
│   ├── os/              # OS-specific configurations
│   ├── term/            # Terminal customizations
│   └── theme/           # Theme overrides
└── functions/
    └── up-to-date.lua   # Auto-update checking system
```

## Dependencies & Requirements

- Neovim 0.10+ (tested on 0.11.2)
- Git (plugin management)
- C compiler (certain plugins)
- Node.js (LSP features)
- Ripgrep (telescope search)
- Nerd Font (icons)
- Platform support: Linux, macOS (Darwin), Windows

## Performance Considerations

- Bytecode caching enabled via `vim.loader.enable()`
- Strategic lazy loading: `event = "VeryLazy"` for non-critical plugins
- File-type specific loading: `ft = { ... }` for language plugins
- Large file optimization via `bigfile.nvim`
- DAP plugins currently disabled for performance

## Testing Changes

When modifying this configuration:
1. Test startup time: `:Lazy profile`
2. Verify plugin health: `:checkhealth`
3. Check for errors in: `:messages`
4. Reload specific plugin: `:Lazy reload <plugin>`
5. Profile startup: `nvim --startuptime startup.log`
