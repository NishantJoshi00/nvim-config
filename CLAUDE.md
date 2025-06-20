# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Environment

This is a Neovim configuration repository built with Lua. The configuration uses the lazy.nvim plugin manager and is designed for cross-platform compatibility (Linux, macOS, Windows).

**Requirements:**
- Neovim 0.10+
- Git, Node.js, Ripgrep, C compiler
- A Nerd Font for proper icon display

## Architecture Overview

The configuration follows a modular architecture with clear separation of concerns:

### Core Structure
- **`init.lua`**: Entry point that sets leader key, loads bootstrap, theme, plugins, config, mappings, masking, and custom modules
- **`lua/bootstrap.lua`**: Handles lazy.nvim plugin manager installation
- **`lua/theme.lua`**: Sets basic Vim options (clipboard, completion, cursor, mouse, etc.)
- **`lua/config.lua`**: Core configuration including LSP handlers, diagnostics, autocmds, and custom commands

### Plugin System
- **`lua/plugins/init.lua`**: Main plugin specification file returning a table of plugin configurations
- **`lua/plugins/config/`**: Individual plugin configurations organized by plugin name
- **`lua/plugins/keybinds/`**: Plugin-specific keybindings separated from configurations

### Key Components
- **Plugin Management**: Uses lazy.nvim with lazy loading (`event = "VeryLazy"`) for performance
- **LSP Integration**: Comprehensive setup with Mason for tool management, nvim-lspconfig, and various language-specific tools
- **Keybind Organization**: All keybindings loaded via `lua/mappings.lua` which requires individual keybind modules
- **Custom Functionality**: Platform-specific customizations in `lua/custom/` directory

## Plugin Architecture Patterns

1. **Configuration Pattern**: Each plugin has its config in `plugins/config/<plugin-name>.lua`
2. **Keybind Pattern**: Plugin keybinds are in `plugins/keybinds/<plugin-name>.lua` and return a function
3. **Lazy Loading**: Most plugins use `event = "VeryLazy"` or specific file type triggers for performance
4. **Dependencies**: Plugin dependencies are explicitly declared in the plugin spec

## Key Features & Components

- **LSP**: Full language server integration with Mason for automatic installation
- **Completion**: nvim-cmp with multiple sources (LSP, buffer, path, snippets)
- **File Navigation**: Telescope for fuzzy finding, nvim-tree and oil.nvim for file exploration
- **Git Integration**: Gitsigns and vim-fugitive for version control
- **Terminal**: toggleterm.nvim for integrated terminal management
- **Debugging**: nvim-dap with UI (currently disabled)
- **Themes**: Multiple theme support with TokyoDark as primary

## Development Commands

### Essential Development Commands
- **`:LuaToBuffer`**: Execute Lua code and output result to current buffer (useful for debugging)
- **`:checkhealth`**: Verify Neovim installation and plugin health
- **`:Lazy`**: Open lazy.nvim UI for plugin management
- **`:Mason`**: Open Mason UI for LSP/DAP/linter/formatter installation

### Plugin Configuration Workflow
When adding new plugins:
1. Add plugin spec to `lua/plugins/init.lua` with proper dependencies
2. Create configuration file in `lua/plugins/config/<plugin-name>.lua` (returns function)
3. Create keybinds file in `lua/plugins/keybinds/<plugin-name>.lua` (returns function)
4. Add keybind require to `lua/mappings.lua`
5. Use `:Lazy reload <plugin-name>` to test changes

### Configuration Debugging
- Use `require("functions").point_search()` (Ctrl+P) for searching specific content
- Use `require("functions").glob_search()` (<leader>fl) for file-pattern searches
- TreeSitter query testing via `<leader>eer` for syntax analysis
- Use `:TSCaptureUnderCursor` to debug TreeSitter highlighting issues

## Loading Order & Initialization

The configuration follows a strict loading order (defined in init.lua:1-9):
1. Leader key setup (must be first)
2. Bootstrap lazy.nvim plugin manager
3. Theme and basic vim options
4. Plugin loading via lazy.nvim
5. Core configuration (LSP, diagnostics, autocmds)
6. Keybinding setup
7. Masking configuration
8. Custom platform/terminal configurations
9. Auto-update check on startup

## Utility Functions

The `lua/utils.lua` module provides helper functions:
- **`gate(fn)`**: Execute platform-specific code based on OS detection
- **`is_day()`**: Check if current time is daytime (for theme switching)
- **`join(...)`**: Create vim option strings from multiple values

## Platform Customization

The configuration supports platform-specific customizations through:
- `lua/custom/os/mac.lua` - macOS specific settings
- `lua/custom/os/windows.lua` - Windows specific settings
- **Note**: Currently loads Windows settings by default in `custom/init.lua` - adjust for your platform

### Critical Architecture Decisions

**Event-Driven Loading Strategy**: 
- Most plugins use `event = "VeryLazy"` to defer loading until after UI initialization
- LSP-related plugins use `event = "LspAttach"` for conditional loading
- File-type specific plugins use `ft = {"rust", "lua"}` etc.

**LSP Configuration Pattern**:
- `mason.nvim` manages LSP server installations
- `mason-lspconfig.nvim` bridges Mason and nvim-lspconfig  
- Language-specific configs (Rust via rustaceanvim, Haskell via haskell-tools.nvim) override defaults
- Capabilities are injected from nvim-cmp for completion integration

**Keybinding Architecture**:
- Leader key (`<space>`) is set FIRST in init.lua (critical for proper plugin loading)
- All keybinds use consistent namespacing: `<leader>f*` (files), `<leader>m*` (markdown), `<leader>g*` (git)
- Plugin-specific keybinds are isolated in separate modules under `keybinds/`

## Auto-Update Mechanism

The configuration includes an automatic update checker (`lua/functions/up-to-date.lua`) that:
- Runs on startup after all plugins load
- Checks if local config is behind remote repository
- Displays notification if updates are available
- Requires git repository setup

## Testing & Validation

Since this is a Neovim configuration, testing involves:
- Loading Neovim and ensuring no errors occur
- Verifying plugin functionality manually
- Checking LSP server installations via Mason
- Testing keybindings and custom commands
- Run `:checkhealth` to verify setup

No automated test suite is present as this is a personal configuration repository.

### Configuration State Management

**Version Control**: Configuration is tracked via `lazy-lock.json` with 73+ pinned plugin versions for reproducibility.

**Auto-Update System**: The `functions/up-to-date.lua` module performs git-based update checking on startup, comparing local HEAD with `origin/main`.

**Performance Monitoring**: Use `:Lazy profile` to analyze startup performance and plugin loading times.

### Custom Function Integration

The configuration includes several custom functions accessible via keybinds:
- **Copy/Scratch Pad System**: `<leader><c-n>` opens persistent copy pad with clipboard integration
- **Theme Cycling**: `<leader>tc` cycles through available themes with time-based defaults
- **Location Copying**: `<leader><c-p>` copies current file:line to clipboard
- **TreeSitter Extraction**: `<leader>eer` provides interactive TreeSitter query interface for code analysis

### Completion System Architecture

**Multi-Source Strategy**: nvim-cmp aggregates from LSP, buffer, path, and snippet sources with intelligent prioritization (LSP > snippets > buffer > path).

**Context-Aware Behavior**: Different completion sources activate based on context (gitcommit uses git source, command line uses cmdline source).

**Integration Points**: Completion capabilities are injected into LSP configs via `cmp_nvim_lsp.default_capabilities()` for seamless LSP-completion integration.

## Performance Considerations

- Plugins are extensively lazy-loaded using `event = "VeryLazy"` or file type triggers
- Some resource-intensive plugins like nvim-dap are disabled by default
- BigFile plugin handles large files efficiently
- Treesitter and LSP are optimized for specific file types
- Diagnostics update in insert mode (intentional for immediate feedback)