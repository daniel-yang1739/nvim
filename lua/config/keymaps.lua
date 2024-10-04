-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Key Mappings --
keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>")
keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>")
keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>")
keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>")

keymap.set("n", "<S-h>", "gT")
keymap.set("n", "<S-l>", "gt")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set({ "v", "n" }, "<leader>y", "\"+y")
