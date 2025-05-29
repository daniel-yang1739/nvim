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
            "node_modules",
            ".git/",
            "__pycache__",
            "local_data",
            "cache",
            "lib/materializecss/",
            "lib/*-dist/",
          },
        },
        pickers = {
          find_files = {
            no_ignore = true,  -- no ignore files in .gitignore
          },
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
