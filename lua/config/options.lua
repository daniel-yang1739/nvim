-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local option = vim.opt
local buffer = vim.b

-- Globol Settings --
option.autoindent = true
option.autoread = true
option.backspace = { "indent", "eol", "start" }
option.backup = false
option.completeopt = { "menuone", "noselect" }
option.cursorline = true
option.expandtab = true
option.exrc = true
-- option.foldmethod = "indent"
option.hlsearch = true
option.ignorecase = true
option.mouse = ""
option.number = true
option.relativenumber = true
option.scrolloff = 12
option.shiftround = true
option.showmode = false
option.signcolumn = "yes"
option.smartcase = true
option.smartindent = true
option.splitright = true
option.swapfile = false
option.shiftwidth = 2
option.tabstop = 2
option.termguicolors = true
option.title = true
option.updatetime = 50
option.wildmenu = true
option.wrap = true

-- Buffer Settings --
buffer.fileencoding = "utf-8"
