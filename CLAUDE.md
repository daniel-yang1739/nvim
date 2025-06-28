# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Neovim configuration repository using the lazy.nvim plugin manager. The configuration follows a modular structure with separate files for different concerns.

## Architecture

- **Entry Point**: `init.lua` - bootstraps the configuration by loading all config modules
- **Configuration**: `lua/config/` - core Neovim settings
  - `lazy.lua` - bootstraps and configures the lazy.nvim plugin manager
  - `options.lua` - Neovim editor options (indentation, UI, behavior)
  - `keymaps.lua` - custom key mappings and leader key (`,`)
  - `autocmds.lua` - autocommands
- **Plugins**: `lua/plugins/` - modular plugin configurations
  - Each file contains related plugin configurations as lazy.nvim specs
  - Plugins are automatically imported via `{ import = "plugins" }` in lazy.lua

## Key Configuration Details

### Plugin Management
- Uses lazy.nvim for plugin management
- Plugin specifications are in `lua/plugins/*.lua` files
- Lock file: `lazy-lock.json` (tracks exact plugin versions)
- Automatic plugin updates are disabled (`checker = { enabled = false }`)

### LSP Setup
- LSP configuration in `lua/plugins/lsp.lua`
- Uses Mason for LSP server management with auto-installation
- Configured LSP servers: Python (pylsp), TypeScript/JavaScript (ts_ls)
- Mason tool installer manages formatters/linters: prettier, isort, yapf, shellcheck, hadolint, luacheck
- none-ls.nvim provides formatting/linting integration with auto-format on save

### Development Tools
- Copilot integration with Alt+Tab acceptance (`lua/plugins/copilot.lua`)
- Terminal integration via toggleterm.nvim with Ctrl+\ toggle
- Git integration via vim-fugitive and vim-gitgutter
- File navigation via telescope.nvim

### Editor Behavior
- Leader key: `,` (comma)
- 4-space indentation with smart indenting
- Relative line numbers enabled
- Mouse disabled
- Arrow keys disabled in all modes
- Tab switching: H (previous), L (next)
- Visual mode line movement: J (down), K (up)

## Common Commands

### Plugin Management
```
:Lazy              # Open lazy.nvim UI
:Lazy update       # Update all plugins
:Lazy sync         # Install missing and update existing plugins
```

### LSP and Development Tools
```
:Mason             # Open Mason UI for LSP servers/tools
:MasonUpdate       # Update Mason itself
:MasonToolsUpdate  # Update all installed tools
gd                 # Go to definition (LSP)
gr                 # Show references (LSP)
```

### File and Git Operations
```
<C-\>              # Toggle terminal
:Git               # Git commands (vim-fugitive)
```

## Formatter/Linter Behavior

The configuration uses conditional formatting based on project configuration files:
- **Prettier**: Only runs if `.prettierrc` exists in project root
- **Python tools (isort/yapf)**: Only run if `pyproject.toml` exists in project root
- **Virtual environment**: Automatically detects and uses `.venv/bin/` executables when available
- **Auto-format**: Enabled on save for supported file types when conditions are met

## Plugin Lock Management

When modifying plugin configurations:
1. Test changes work as expected
2. Use `:Lazy sync` to update lock file
3. Commit both plugin changes and updated `lazy-lock.json`