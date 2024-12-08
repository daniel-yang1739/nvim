-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local option = vim.opt
local buffer = vim.b

-- Globol Settings --
-- option.foldmethod = "indent"
option.autoindent = true
option.autoread = true
option.backspace = { "indent", "eol", "start" }
option.backup = false
option.completeopt = { "menuone", "noselect" }
option.cursorline = true
option.expandtab = true
option.exrc = true
option.hlsearch = true
option.ignorecase = true
option.mouse = ""
option.number = true
option.relativenumber = true
option.scrolloff = 4
option.shiftround = true
option.shiftwidth = 4
option.showmode = false
option.signcolumn = "yes"
option.smartcase = true
option.smartindent = true
option.splitright = true
option.swapfile = false
option.tabstop = 4
option.termguicolors = true
option.title = true
option.updatetime = 50
option.wildmenu = true
option.wrap = true

-- Buffer Settings --
buffer.fileenconding = "utf-8"
