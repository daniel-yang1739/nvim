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
  {
    'stevearc/aerial.nvim',
    config = function()
      require('aerial').setup({
        backend = "treesitter",
        layout = {
          default_direction = "float",
          min_width = 60,
          max_width = { 120, 0.2 },
        },
        float = {
          relative = "editor",
          border = "rounded",
          height = 0.8,
        },
        filter_kind = {
          "Class",
          "Function",
          "Constructor",
          "Method",
          "Interface",
        },
        on_attach = function(bufnr)
          vim.keymap.set('n', 'za', '<cmd>AerialToggle<CR>', { buffer = bufnr, desc = "toggle aerial" })
        end
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python",
          "angular",
          "javascript",
          "typescript",
          "html",
          "css",
          "json",
          "bash",
          "yaml",
          "markdown",
          "dockerfile",
          "cpp",
          "java",
          "lua",
          "vim",
          "vimdoc",
        },

        sync_install = false,
        auto_install = true,

        highlight = {
          enable = true,
        },
      })
    end,
  }
}
