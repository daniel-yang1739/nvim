local colors = require('constant.colors')
return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'nord',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,

          globalstatus = true,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          },
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {
            'branch',
            {
              'diff',
              diff_color = {
                added    = { fg = colors.git.add },
                modified = { fg = colors.git.change },
                removed  = { fg = colors.git.delete },
              }
            },
            'diagnostics'
          },
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
      })
    end,
  },
  {
  "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    opts = {
      preset = 'obsidian',
      enabled = false,
      anti_conceal = { enabled = false },
      code = { sign = false },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      vim.keymap.set("n", "<leader>m", ":RenderMarkdown toggle<CR>", { silent = true, desc = "Toggle Markdown Render" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    lazy = false,
    build = ":TSUpdate",
    config = function(_, _)
      local langs = {
        "python", "angular", "javascript", "typescript", "html",
        "css", "json", "bash", "yaml", "markdown",
        "dockerfile", "cpp", "java", "lua", "vim", "vimdoc", "go"
      }

      require('nvim-treesitter').install(langs)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = langs,
        callback = function()
          -- Syntax highlighting (provided by Neovim)
          vim.treesitter.start()

          -- Folding (provided by Neovim)
          -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.wo.foldmethod = 'expr'

          -- Indentation (provided by nvim-treesitter, experimental)
          -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  }
}
