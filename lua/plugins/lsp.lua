return {
  -- Installer
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  -- LSP Installer
  {
    "williamboman/mason-lspconfig.nvim",
    version = "1.32.0",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pylsp",          -- Python
          "ts_ls",          -- TS/JS
          "html",           -- Angular template
          "jsonls",         -- JSON
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.pylsp.setup({
        settings = {
          pylsp = {
            plugins = {
              flake8 = { enabled = true },         -- Enable flake8
            },
          },
        },
      })
      lspconfig.ts_ls.setup({})
      lspconfig.html.setup({})
      lspconfig.jsonls.setup({})

      --[[
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
        pattern = { "*.ts", "*.js", "*.py", "*.json", "*.html" },
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
      ]]--
    end,
  },

  -- Formatter / Linter
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- JavaScript / TypeScript / JSON / Angular
          null_ls.builtins.formatting.prettier,
          -- Python import sorter
          null_ls.builtins.formatting.isort.with({
            extra_args = { "--force-single-line-imports" }
          }),
          -- Python formatter
          null_ls.builtins.formatting.black.with({
            extra_args = { "--line-length", "79" }
          }),
        },
      })
    end,
  },
}
