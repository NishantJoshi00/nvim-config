# Neovim Configuration

<div align="center">
    <a href="https://dotfyle.com/NishantJoshi00/nvim-config"><img src="https://dotfyle.com/NishantJoshi00/nvim-config/badges/plugins?style=for-the-badge" /></a>
    <a href="https://dotfyle.com/NishantJoshi00/nvim-config"><img src="https://dotfyle.com/NishantJoshi00/nvim-config/badges/leaderkey?style=for-the-badge" /></a>
    <a href="https://dotfyle.com/NishantJoshi00/nvim-config"><img src="https://dotfyle.com/NishantJoshi00/nvim-config/badges/plugin-manager?style=for-the-badge" /></a>
</div>

## Overview

A modular Neovim configuration built around `lazy.nvim` for performance, with a strict three-layer separation between plugin specifications, configurations, and keybindings. The repository is treated as a small codebase rather than a dotfile dump: configs and keybinds are wrapped in functions for deferred execution, errors are isolated with `pcall`, and platform-specific behavior is gated rather than branched.

**Architecture:**
- Three-layer plugin pattern: spec (`plugins/init.lua`), config (`plugins/config/`), keybinds (`plugins/keybinds/`)
- Event-driven lazy loading (`VeryLazy`, `BufReadPre`, `InsertEnter`, `LspAttach`, filetype, command)
- Strict initialization order: bytecode cache → leader key → theme options → bootstrap → plugins → config → mappings → masking → custom
- Platform-specific overrides for macOS, Linux, and Windows via `utils.gate()`
- Mason-managed LSP servers, with language-specific tooling for Rust (`rustaceanvim`) and Haskell (`haskell-tools.nvim`)

**Tested on:**
- Neovim 0.11.2+ (requires Neovim 0.10+ for `vim.loader`, `vim.lsp.inlay_hint`, and the new diagnostic API)
- macOS (Darwin 24.2.0) and Linux

## Installation

1. Ensure Neovim 0.10+ is installed.

2. Back up any existing configuration:
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

4. Install runtime dependencies:
   - **Git** — plugin management
   - **C compiler** — needed for plugins like `telescope-fzf-native` and `blink.cmp` (Rust fuzzy matcher)
   - **Node.js** — most LSP servers
   - **Ripgrep** — Telescope live grep, `:grep` integration
   - **curl** — required by the AI note integration (`lua/ai/`)
   - **Nerd Font** — icon rendering (mono variant configured for `blink.cmp`)

5. Launch Neovim. On first start the configuration will:
   - Bootstrap `lazy.nvim` (auto-clone if missing)
   - Install all plugins
   - Install LSP servers, formatters, and linters via Mason

## Features

**Core:**
- LSP via `nvim-lspconfig` + Mason ecosystem (`mason.nvim`, `mason-lspconfig.nvim`)
- Completion through `blink.cmp` (LSP, snippets, buffer, path; Rust fuzzy matcher)
- Treesitter syntax/indent (main branch, with the new `nvim-treesitter` API)
- Git integration: `gitsigns`, `vim-fugitive`, `diffview.nvim`
- File navigation: `telescope.nvim` (with `fzf-native`) and `oil.nvim` (buffer-as-directory)
- Project-wide search/replace via `grug-far.nvim`
- Terminal: `toggleterm.nvim` (Ctrl-t toggle in normal/insert/terminal modes)
- Session persistence: `persistence.nvim`
- LSP diagnostics: virtual text + `nvim-lsp-endhints` for inline end-of-line hints
- Quickfix UX: `quicker.nvim`
- Statusline: `lualine`; tabline: `bufferline`; breadcrumbs: `nvim-navic`
- Notifications: `nvim-notify`; UI prompts: `dressing.nvim`; keymap discovery: `which-key.nvim`
- Dashboard: `dashboard-nvim` with ASCII art

**Language Support:**
- **Rust** — `rustaceanvim` with rust-analyzer settings in `lua/opts/init.lua`, plus `crates.nvim` for `Cargo.toml`
- **Haskell** — `haskell-tools.nvim` (filetype trigger)
- **Lua** — `lazydev.nvim` for Neovim API completion
- **Markdown** — `vim-markdown` + `render-markdown.nvim` for in-buffer rendering
- **TLA+** — `vim-tla`
- **Generic** — anything Mason can install via the default LSP handler in `config.lua`

**Custom modules** (beyond plugin glue):
- **Buffer masking** (`masking.lua` + `disabler.lua`) — toggles every listed buffer between modifiable and readonly, serializing/deserializing all keybindings. Designed for code-review sessions. Bound to `<leader><c-d>` / `<leader><c-a>`.
- **Markdown tree** (`markdown-tree.lua`) — parses markdown checklists into an interactive NUI tree with toggle and persist-back-to-file. Bound under `<leader>M*`.
- **AI note operations** (`lua/ai/interface.lua`) — OpenAI-compatible client (curl-based) for smart-append, summarize, and reorganize over markdown notes.
- **Scratch and copy pads** (`functions.lua`) — NUI popups for ephemeral notes, with `<c-n>` / `<leader><c-n>`.
- **Point search** (`functions.lua`) — `file:line:col` jump bound to `<c-p>`.
- **Auto-update check** (`functions/up-to-date.lua`) — async `git fetch` on startup, non-blocking, notifies if behind.

**Key Bindings:**
- Leader: `<space>`
- `<leader>f*` — find/file (Telescope)
- `<leader>g*` — git
- `<leader>m*` / `<leader>M*` — markdown / markdown tree
- `<leader>e*` — editor
- `<leader>b*` — buffers
- `<leader>c*` — quickfix list
- `<c-p>` — point search, `<c-n>` — scratch pad, `<c-t>` — terminal toggle, `<c-u>` — undotree

## Project Structure

```
.
├── init.lua                        # Entry point; enforces strict load order
├── lua/
│   ├── bootstrap.lua               # Auto-installs lazy.nvim if missing
│   ├── theme.lua                   # Core vim options (loaded BEFORE plugins)
│   ├── config.lua                  # Diagnostics, float highlights, LspAttach autocmd
│   ├── mappings.lua                # Loader for all keybind modules
│   ├── masking.lua                 # Buffer mutability (code-review mode)
│   ├── disabler.lua                # Keymap serialize/deserialize backing masking
│   ├── markdown-tree.lua           # Interactive markdown checklist tree
│   ├── functions.lua               # Quoter, point search, copy/scratch pads, glob search
│   ├── utils.lua                   # Platform gating (gate, is_day, join)
│   ├── exports.lua                 # Shared color palette
│   ├── quickfix.lua                # errorformat templates (rust, python)
│   ├── ai/
│   │   ├── interface.lua           # OpenAI-compatible chat client (curl)
│   │   └── prompts.lua             # System prompts: append/summary/reorganize
│   ├── functions/
│   │   └── up-to-date.lua          # Async git-fetch update check
│   ├── opts/
│   │   └── init.lua                # rust-analyzer settings for rustaceanvim
│   ├── plugins/
│   │   ├── init.lua                # Plugin specifications only (no config code)
│   │   ├── config/                 # Per-plugin config functions (deferred)
│   │   └── keybinds/               # Per-plugin keymap functions
│   └── custom/
│       ├── init.lua                # Loads platform/terminal/theme overrides
│       ├── os/{mac,windows}.lua    # Platform-gated settings
│       ├── term/kitty.lua          # Terminal-specific tweaks
│       └── theme/catppuccin.lua    # Alternate theme palette
├── data/                           # Persistent runtime data (gitkept)
├── spell/                          # Custom spellfile (en.utf-8.add)
└── .github/workflows/              # Claude Code Review + PR Assistant workflows
```

## Development Workflow

### Adding a new plugin

The codebase enforces a strict three-step pattern. Skip the wrapping function and lazy loading breaks.

1. **Specification** in `lua/plugins/init.lua` — only the spec, never config code:
   ```lua
   {
       "author/plugin-name",
       event = "VeryLazy",
       dependencies = { ... },
       config = require("plugins.config.plugin-name"),
   }
   ```

2. **Configuration** in `lua/plugins/config/plugin-name.lua` — must return a function:
   ```lua
   return function()
       local ok, plugin = pcall(require, "plugin-name")
       if not ok then
           vim.notify("Failed to load plugin-name", vim.log.levels.ERROR)
           return
       end
       plugin.setup({ ... })
   end
   ```

3. **Keybindings** in `lua/plugins/keybinds/plugin-name.lua` — also returns a function, and must be registered in `mappings.lua`:
   ```lua
   return function()
       vim.keymap.set("n", "<leader>xx", function() ... end, { desc = "..." })
   end
   ```

4. Reload without restarting: `:Lazy reload plugin-name`.

### Debugging

- `:checkhealth` — verify install + plugin health
- `:Lazy profile` — analyze startup timing
- `:Lazy load <plugin>` — force-load to test in isolation
- `:messages` — see startup errors
- `:LspInfo` / `:LspLog` — LSP wiring
- `:TSCaptureUnderCursor` / `:InspectTree` — Treesitter debugging
- `:LuaToBuffer <code>` — execute Lua and append output to current buffer (debug only; executes arbitrary code)
- `:verbose map <leader>xx` — show what registered a keybind

## Contributing

1. Fork and create a feature branch.
2. Follow the existing modular conventions (no config code in `plugins/init.lua`, no mixing keybinds with config, no globals — see `CLAUDE.md` for the full rules).
3. Verify changes with `:checkhealth`, `:Lazy profile`, and `:messages`.
4. Open a PR with a clear description of what changed and why.

See [`CLAUDE.md`](CLAUDE.md) for the full architecture guide, critical patterns, and common pitfalls.
