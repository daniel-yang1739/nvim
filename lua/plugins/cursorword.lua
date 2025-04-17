return {
  {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup({
        cursorline = {
          -- use nvim default cursorline
          enable = false,
        }
      })
    end,
  },
  {
    "easymotion/vim-easymotion",
  }
}
