return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
    },
  },
  {
    "airblade/vim-gitgutter",
    event = "BufReadPre",
  },
}
