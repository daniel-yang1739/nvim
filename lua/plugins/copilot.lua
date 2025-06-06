return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<A-tab>",
            accept_word = "<A-w>",
            accept_line = "<A-l>",
          },
        }
      })
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      debug = true,
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    build = "make",
    config = function()
      local opts = {
        provider = "copilot",
        copilot = {
          -- https://github.com/yetone/avante.nvim?tab=readme-ov-file#disable-tools
          disable_tools = true,
        },
        windows = {
          input ={
            prefix = "",
            height = 6,
          },
          ask = {
            border = "rounded",
            start_insert = true
          },
        },
      }
      require("avante").setup(opts)
    end,
  },
}
