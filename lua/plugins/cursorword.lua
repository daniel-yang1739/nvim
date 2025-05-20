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
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      enabled = false,
    },
    config = function(_, opts)
      require("hardtime").setup(opts)
    end,
  }
}
