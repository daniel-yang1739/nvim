return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "find files" },
      { "<leader>p", "<cmd>Telescope find_files<cr>", desc = "find files" },
      { "<leader>o", "<cmd>Telescope live_grep<cr>", desc = "live grep" }
    },
    opts = function()
      return {
        defaults = {
          layout_config = {
            width = 0.9,
            height = 0.9,
          },
          --  disable file preview
          preview = {
            hide_on_startup = true,
          },
          file_ignore_patterns = {
            "node_modules",
            "__pycache__",
            "lib/materializecss",
            "lib/*-dist",
          },
        },
      }
    end
  },
}
