# Neovim Configuration

<div align="center">
    <a href="https://dotfyle.com/NishantJoshi00/nvim-config"><img src="https://dotfyle.com/NishantJoshi00/nvim-config/badges/plugins?style=for-the-badge" /></a>
    <a href="https://dotfyle.com/NishantJoshi00/nvim-config"><img src="https://dotfyle.com/NishantJoshi00/nvim-config/badges/leaderkey?style=for-the-badge" /></a>
    <a href="https://dotfyle.com/NishantJoshi00/nvim-config"><img src="https://dotfyle.com/NishantJoshi00/nvim-config/badges/plugin-manager?style=for-the-badge" /></a>
</div>

## Overview

A modular Neovim configuration with 80+ plugins, built for performance using lazy.nvim and event-driven loading. Features comprehensive LSP integration, cross-platform support, and a clear separation between core configuration, plugins, and keybindings.

**Architecture:**
- Modular design with dedicated directories for plugins, configs, and keybinds
- Event-driven lazy loading using `event = "VeryLazy"` and file-type triggers
- Platform-specific customizations for Linux, macOS, and Windows
- Strict initialization order: bootstrap → theme → plugins → config → mappings
- Mason-managed LSP servers, formatters, and linters

**Tested on:**
- Neovim v0.11.2+ (requires Neovim 0.10+)
- macOS (Darwin 24.2.0)
- 80+ plugins tested and configured for stability

## Installation

1. Ensure Neovim 0.10+ is installed

2. Back up existing configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

3. Clone this repository:
   ```bash
   # Linux/macOS
   git clone https://github.com/NishantJoshi00/nvim-config.git ~/.config/nvim

   # Windows (PowerShell)
   git clone https://github.com/NishantJoshi00/nvim-config.git $env:LOCALAPPDATA\nvim
   ```

4. Install dependencies:
   - Git (plugin management)
   - C compiler (certain plugins require compilation)
   - Node.js (LSP features)
   - Ripgrep (telescope search)
   - Nerd Font (icon rendering)

5. Launch Neovim. The configuration will automatically:
   - Install lazy.nvim plugin manager
   - Download and configure all plugins
   - Set up LSP servers via Mason

## Features

**Core Capabilities:**
- LSP integration with nvim-lspconfig and Mason
- Multi-source completion via nvim-cmp (LSP, buffer, path, snippets)
- Git integration with gitsigns, vim-fugitive, and diffview
- File navigation using Telescope, nvim-tree, and oil.nvim
- TreeSitter syntax highlighting and code analysis
- Terminal integration via toggleterm.nvim
- Session management with persistence.nvim
- Enhanced diagnostics with lsp_lines and virtual text

**Language Support:**
- Rust (rustaceanvim with enhanced tooling)
- Haskell (haskell-tools.nvim)
- Zig (zig.vim)
- Lua (lazydev.nvim for Neovim API development)
- TLA+ (vim-tla for specifications)
- General purpose via Mason LSP management

**Key Bindings:**
- Leader key: `<space>`
- Consistent namespacing: `<leader>f*` (find/file), `<leader>g*` (git), `<leader>m*` (misc)
- Plugin-specific bindings isolated in `lua/plugins/keybinds/`

## Project Structure

```
.
├── init.lua                # Entry point with strict loading order
├── lua/
│   ├── bootstrap.lua       # lazy.nvim setup (auto-installs if missing)
│   ├── theme.lua          # Core vim options (loaded before plugins)
│   ├── config.lua         # LSP setup, diagnostics, autocmds
│   ├── mappings.lua       # Keybinding loader
│   ├── functions.lua      # Utility functions
│   ├── plugins/
│   │   ├── init.lua       # Plugin specifications (80+)
│   │   ├── config/        # Plugin configurations (return functions)
│   │   └── keybinds/      # Plugin keybindings (return functions)
│   ├── custom/
│   │   ├── init.lua       # Platform-specific loader
│   │   └── os/            # OS-specific configurations
│   └── functions/
│       └── up-to-date.lua # Auto-update checking
└── docs/
    └── plugins.md         # Complete plugin catalog
```

## Development Workflow

**Adding New Plugins:**

1. Add plugin specification to `lua/plugins/init.lua`:
   ```lua
   {
       "author/plugin-name",
       event = "VeryLazy",
       dependencies = { ... },
       config = require("plugins.config.plugin-name"),
   }
   ```

2. Create configuration in `lua/plugins/config/plugin-name.lua`:
   ```lua
   return function()
       require("plugin-name").setup({ ... })
   end
   ```

3. Create keybindings in `lua/plugins/keybinds/plugin-name.lua`:
   ```lua
   return function()
       vim.keymap.set("n", "<leader>xx", function() ... end, { desc = "..." })
   end
   ```

4. Load keybindings in `lua/mappings.lua`:
   ```lua
   require("plugins.keybinds.plugin-name")()
   ```

5. Test with `:Lazy reload plugin-name`

**Debugging Tools:**
- `:checkhealth` - Verify installation and plugin health
- `:Lazy profile` - Analyze startup performance
- `:TSCaptureUnderCursor` - Debug TreeSitter highlighting
- `:LuaToBuffer <code>` - Execute Lua and append output to buffer
- `require("functions").point_search()` - Navigate to file:line:col

## Documentation

[Complete Plugin Catalog](docs/plugins.md) - All 80+ plugins organized by category with GitHub links and descriptions.

## Contributing

1. Fork the repository and create a feature branch
2. Follow the modular architecture:
   - Plugin configs return functions for lazy loading
   - Use consistent leader key namespacing
   - Maintain separation between config and keybinds
3. Test changes:
   - Run `:checkhealth` to verify plugin health
   - Run `:Lazy profile` to check performance impact
   - Ensure no startup errors with `:messages`
4. Submit a pull request with clear description
