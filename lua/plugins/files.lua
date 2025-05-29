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
            width = 0.8,
            height = 0.8,
          },
          --  disable file preview
          preview = {
            hide_on_startup = true,
          },
          file_ignore_patterns = {
            "lib/materializecss",
            "lib/*-dist",
          },
        },
        pickers = {
          pickers = {
            find_files = {
              hidden = true,
              no_ignore = false,
            },
          }
        },
      }
    end
  },
  {
    --[[
    -- File Explorer --
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      local keymap = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      keymap('n', '<leader>n', '<cmd>NvimTreeToggle<cr>', opts)
    end,
    config = function()
      require("nvim-tree").setup({
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })
    end,
    ]]--
  },
}
