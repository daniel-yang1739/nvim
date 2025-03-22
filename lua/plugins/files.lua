return {
  {
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
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "find files" }
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
        },
        pickers = {
          find_files = {
            find_command = {
              "ag",
              "--silent",
              "--nocolor",
              "--follow",
              "-g", "",
              "--literal",
              "--ignore",
              ".git",
              "--ignore",
              "node_modules",
              "--ignore",
              "__pycache__",
            },
          },
        },
      }
    end
  },
  {
    --[[
    -- Find Files --
    "ctrlpvim/ctrlp.vim",
    config = function()
      -- Set wildignore patterns
      vim.o.wildignore = vim.o.wildignore .. '/tmp/,.so,.swp,.zip,.,env,*.pyc'

      if vim.fn.executable('ag') then
        -- Use Ag in CtrlP for listing files. Lightning fast and respects .gitignore
        vim.g.ctrlp_user_command = 'ag %s --skip-vcs-ignores --ignore-dir=node_modules --ignore-dir=__pycache__ -l -g ""'

        -- Set Ag as the grepprg
        vim.o.grepprg = 'ag --nogroup --nocolor'
      end
    end
    ]]--
  },
}
