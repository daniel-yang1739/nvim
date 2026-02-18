# Neovim Configuration

A modular, high-performance Neovim configuration built with `lazy.nvim`, featuring LSP support, auto-formatting, and modern UI enhancements.

## 🚀 Quick Start

### 1. Prerequisites

Ensure you have the following installed on your system:

- **Neovim** (v0.10+ recommended)
- **Node.js & npm** (for LSP and Copilot)
- **Go** (for Go LSP and tools)
- **Python 3 & pip** (for Python LSP and tools)
- **Ripgrep** (for Telescope searching)
- **Build Essentials**:
  ```bash
  sudo apt install -y libffi-dev libssl-dev liblzma-dev libreadline-dev libsqlite3-dev zlib1g-dev tk-dev libbz2-dev libncursesw5-dev build-essential
  ```

### 2. Setup Locale
If your system does not have `en_US.UTF-8`, set it up to avoid encoding issues:
```bash
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8
locale -a
```

### 3. Installation

Clone this repository into your Neovim configuration directory:
```bash
git clone https://github.com/your-username/your-repo.git ~/.config/nvim
```

Launch Neovim, and `lazy.nvim` will automatically install the plugins.

---

## 🛠️ Key Features

- **LSP Support**: Out-of-the-box support for Python (`pylsp`), TypeScript/JS (`ts_ls`), and Go (`gopls`).
- **Auto-Formatting**: Integrated with `none-ls.nvim`.
  - **Prettier**: Runs if `.prettierrc` is present.
  - **Python (isort/yapf)**: Runs if `pyproject.toml` is present (supports `.venv` detection).
- **AI-Powered**: GitHub Copilot integration with custom shortcuts.
- **Terminal**: Integrated floating terminal via `toggleterm.nvim`.
- **Navigation**: 
  - **Telescope**: Powerful fuzzy finding for files and grep.
  - **EasyMotion**: Fast jumping within files.
- **UI**: 
  - **Tokyonight** theme.
  - **Lualine**: Clean status line.
  - **Indent Blankline**: Visual indent guides.

---

## ⌨️ Keymaps

The **Leader Key** is set to `,` (comma).

### Navigation & Editing
| Shortcut | Description |
|----------|-------------|
| `H` / `L` | Switch Tabs (Previous / Next) |
| `<C-p>` / `<leader>p` | Find Files (Telescope) |
| `<leader>o` | Live Grep (Telescope) |
| `J` / `K` (Visual) | Move selected lines Up / Down |
| `<leader>y` (Visual) | Copy to system clipboard |
| `<leader>'` / `"` | Wrap word/selection in quotes |

### LSP & Development
| Shortcut | Description |
|----------|-------------|
| `gd` | Go to Definition |
| `gr` | Show References |
| `<leader>e` | Show Diagnostics (Float) |
| `<C-\>` | Toggle Floating Terminal |
| `<leader>gs` | Git Status |

### Copilot
| Shortcut | Description |
|----------|-------------|
| `Alt + Tab` | Accept Suggestion |
| `Alt + w` | Accept Word |
| `Alt + l` | Accept Line |

---

## 📂 Project Structure

- `init.lua`: Main entry point.
- `lua/config/`: Core settings.
  - `options.lua`: Editor options (2-space indent, relative numbers).
  - `keymaps.lua`: Global keybindings.
  - `autocmds.lua`: Automatic behavior.
- `lua/plugins/`: Modular plugin specifications.
  - `lsp.lua`: LSP, linting, and formatting setup.
  - `ui.lua`: Aesthetics and status line.
  - `files.lua`: Navigation and Telescope.
