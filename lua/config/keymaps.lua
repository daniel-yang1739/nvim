-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Global Leader Key --
local global = vim.g
global.mapleader = ","

-- Key Mappings --
local keymap = vim.keymap
keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>")
keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>")
keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>")
keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>")

keymap.set("v", "<leader>y", '"+y')

keymap.set('n', "<leader>'", "viw<esc>a'<esc>bi'<esc>el")
keymap.set('n', '<leader>"', 'viw<esc>a"<esc>bi"<esc>el')
keymap.set('v', "<leader>'", "<esc>`>a'<esc>`<i'<esc>")
keymap.set('v', '<leader>"', '<esc>`>a"<esc>`<i"<esc>')

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
