# NVIM Configuration

<div align="center">
    <a href="https://dotfyle.com/NishantJoshi00/nvim-config"><img src="https://dotfyle.com/NishantJoshi00/nvim-config/badges/plugins?style=for-the-badge" /></a>
    <a href="https://dotfyle.com/NishantJoshi00/nvim-config"><img src="https://dotfyle.com/NishantJoshi00/nvim-config/badges/leaderkey?style=for-the-badge" /></a>
    <a href="https://dotfyle.com/NishantJoshi00/nvim-config"><img src="https://dotfyle.com/NishantJoshi00/nvim-config/badges/plugin-manager?style=for-the-badge" /></a>
</div>

## Description

A modern, feature-rich Neovim configuration built with a modular architecture and event-driven loading strategy for optimal performance. This configuration follows clear separation of concerns with dedicated modules for plugins, configurations, and keybindings.

**Architecture Highlights:**

- **Modular Design**: Clear separation between core config, plugins, and keybindings
- **Performance Optimized**: Lazy loading with `event = "VeryLazy"` and file-type triggers
- **Cross-Platform**: Linux, macOS, and Windows support with platform-specific customizations
- **LSP-Centric**: Comprehensive language server integration with Mason tool management
- **Event-Driven**: Strategic plugin loading order with automatic update checking

**Tested Environment:**
- **Neovim**: v0.11.2 (Release build with LuaJIT 2.1.1748459687)
- **Platform**: macOS (Darwin 24.2.0)
- **80+ Plugins**: All tested and configured for stability

## Installation

1. Ensure you have Neovim 0.10+ installed on your system
2. Back up your existing Neovim configuration if needed:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

3. Clone this repository to your Neovim configuration directory:

   ```bash
   # Linux/MacOS
   git clone https://github.com/NishantJoshi00/nvim-config.git ~/.config/nvim

   # Windows (PowerShell)
   git clone https://github.com/NishantJoshi00/nvim-config.git $env:LOCALAPPDATA\nvim
   ```

4. Install required dependencies:

   - Git (for plugin management)
   - A C compiler (for certain plugins)
   - Node.js (for LSP features)
   - Ripgrep (for telescope search)
   - A Nerd Font (for icons)

5. Launch Neovim. The configuration will automatically:
   - Install the lazy.nvim plugin manager
   - Download and configure all plugins
   - Set up LSP servers and tools

## Features

### Core Architecture

- **Modular Plugin System**: Plugins organized in `lua/plugins/` with separate config and keybind modules
- **Event-Driven Loading**: Strategic lazy loading using `event = "VeryLazy"` and file-type triggers
- **Configuration Hierarchy**: Clear loading order from bootstrap → theme → plugins → config → mappings
- **Platform Customization**: OS-specific configurations in `lua/custom/os/` directory

### Language & Development Tools

- **LSP Integration**: Mason-managed language servers with nvim-lspconfig and language-specific configs
- **Multi-Source Completion**: nvim-cmp with LSP, buffer, path, and snippet sources
- **Git Workflow**: Gitsigns and vim-fugitive for comprehensive version control
- **File Navigation**: Telescope fuzzy finding + nvim-tree + oil.nvim for flexible file management
- **Terminal Integration**: toggleterm.nvim for integrated terminal sessions

### Advanced Features

- **TreeSitter Integration**: Enhanced syntax highlighting with interactive query interface (`<leader>eer`)
- **Custom Functions**: Copy/scratch pad system, theme cycling, location copying utilities
- **Auto-Update System**: Git-based configuration update checking on startup
- **Performance Monitoring**: Built-in startup profiling with `:Lazy profile`
- **Debug Support**: nvim-dap configuration (currently disabled for performance)

### Key Bindings & Navigation

- **Leader Key Strategy**: `<space>` leader with consistent namespacing (`<leader>f*`, `<leader>g*`, `<leader>m*`)
- **Plugin-Specific Bindings**: Isolated keybind modules in `lua/plugins/keybinds/`
- **Custom Commands**: `:LuaToBuffer`, `:checkhealth`, development-focused commands

## Project Structure

```
lua/
├── init.lua                 # Entry point with strict loading order
├── bootstrap.lua           # lazy.nvim plugin manager setup
├── theme.lua              # Basic vim options and theme setup
├── config.lua             # Core config: LSP, diagnostics, autocmds
├── mappings.lua           # Keybinding loader
├── utils.lua              # Helper functions (gate, is_day, join)
├── plugins/
│   ├── init.lua           # Main plugin specifications
│   ├── config/            # Individual plugin configurations
│   └── keybinds/          # Plugin-specific keybindings
├── custom/
│   ├── init.lua           # Platform-specific loader
│   └── os/                # OS-specific configurations
└── functions/             # Custom utility functions
```

## Development Workflow

**Adding New Plugins:**
1. Add plugin spec to `lua/plugins/init.lua` with dependencies
2. Create config in `lua/plugins/config/<plugin-name>.lua` (returns function)
3. Create keybinds in `lua/plugins/keybinds/<plugin-name>.lua` (returns function)
4. Add keybind require to `lua/mappings.lua`
5. Use `:Lazy reload <plugin-name>` to test

**Configuration Debugging:**
- `:checkhealth` - Verify installation and plugin health
- `:Lazy profile` - Analyze startup performance
- `require("functions").point_search()` (Ctrl+P) - Content search
- `:TSCaptureUnderCursor` - Debug TreeSitter highlighting

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Development Workflow](#development-workflow)
- [Documentation](#documentation)
  - [Complete Plugin Catalog](docs/plugins.md) - All 80+ plugins organized by category
- [Contributing Guidelines](#contributing-guidelines)

## Documentation

📖 **[Complete Plugin Catalog](docs/plugins.md)** - Comprehensive list of all 80+ plugins organized by category with GitHub links and descriptions

## Contributing Guidelines

1. Fork the repository and create your feature branch
2. Follow the modular architecture patterns:
   - Plugin configs return functions for lazy loading
   - Keybinds use consistent leader key namespacing
   - Maintain separation between config and keybinds
3. Test thoroughly with `:checkhealth` and `:Lazy profile`
4. Submit a pull request with clear description

## Acknowledgments

- Built with the powerful Neovim editor
- Inspired by various community configurations
- Made possible by the amazing Neovim plugin ecosystem

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
