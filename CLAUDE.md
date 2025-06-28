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
- Copilot integration with enhanced keybindings (`lua/plugins/copilot.lua`)
  - Alt+Tab: Accept suggestion
  - Alt+w: Accept word
  - Alt+l: Accept line
- Terminal integration via toggleterm.nvim with floating terminal (Ctrl+\)
  - Floating window with curved borders (120x35 dimensions)
  - Transparency and styled borders
- Git integration via vim-fugitive and vim-gitgutter
- File navigation via telescope.nvim with enhanced layout
  - 90% width/height layout
  - Custom file ignore patterns (node_modules, __pycache__, etc.)
  - Preview disabled by default

### UI and Enhancement Plugins
- **lualine.nvim**: Customizable status line with tokyonight theme
- **indent-blankline.nvim**: Visual indent guides
- **nvim-cursorline**: Cursor word highlighting (cursorline disabled)
- **vim-easymotion**: Quick navigation and motion commands
- **hardtime.nvim**: Training plugin for breaking bad habits (disabled)
- **lorem.nvim**: Lorem ipsum text generation

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

### File and Navigation Operations
```
<C-p>              # Find files (Telescope)
<leader>p          # Find files (Telescope)
<leader>o          # Live grep (Telescope)
<C-\>              # Toggle floating terminal
:Git               # Git commands (vim-fugitive)
<leader>gs         # Git status
```

### Text and Clipboard Operations
```
<leader>y          # Copy to system clipboard (visual mode)
<leader>'          # Wrap word/selection in single quotes
<leader>"          # Wrap word/selection in double quotes
```

### Copilot Commands
```
<A-Tab>            # Accept Copilot suggestion
<A-w>              # Accept word from Copilot
<A-l>              # Accept line from Copilot
```

### Utility Commands
```
:LoremIpsum        # Generate lorem ipsum text
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