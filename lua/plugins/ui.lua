return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'everforest',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,

          globalstatus = false,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
  {
    --[[
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false

      local keymap = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      keymap('n', '<A-,>', ':BufferPrevious<CR>', opts)
      keymap('n', '<A-.>', ':BufferNext<CR>', opts)
      keymap('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
      keymap('n', '<A->>', ':BufferMoveNext<CR>', opts)

      keymap('n', '<A-1>', ':BufferGoto 1<CR>', opts)
      keymap('n', '<A-2>', ':BufferGoto 2<CR>', opts)
      keymap('n', '<A-3>', ':BufferGoto 3<CR>', opts)
      keymap('n', '<A-4>', ':BufferGoto 4<CR>', opts)
      keymap('n', '<A-5>', ':BufferGoto 5<CR>', opts)
      keymap('n', '<A-6>', ':BufferGoto 6<CR>', opts)
      keymap('n', '<A-7>', ':BufferGoto 7<CR>', opts)
      keymap('n', '<A-8>', ':BufferGoto 8<CR>', opts)
      keymap('n', '<A-9>', ':BufferLast<CR>', opts)

      keymap('n', '<A-c>', ':BufferClose<CR>', opts)
      keymap('n', '<A-C>', ':BufferCloseAllButCurrent<CR>', opts)

      -- pin/unpin
      keymap('n', '<A-p>', ':BufferPin<CR>', opts)

      -- sort
      keymap('n', '<A-o>', ':BufferOrderByDirectory<CR>', opts)
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
    --]]
  },
}
