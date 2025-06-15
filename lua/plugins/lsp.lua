return {
  -- Installer
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
    opts = {
      ensure_installed = {
        "prettier",       -- JS/TS Formatter
        "isort",          -- Python Import Sorter
        "yapf",           -- Python Formatter
        "shellcheck",     -- Shell Linter
        "hadolint",       -- Haskell Linter
        "luacheck",       -- Lua Linter
      },
      automatic_installation = true,
    },
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
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      end

      lspconfig.pylsp.setup({
        on_attach = on_attach,
        settings = {
          pylsp = {
            plugins = {
              flake8 = { enabled = true },         -- Enable flake8
            },
          },
        },
      })

      lspconfig.ts_ls.setup({
        on_attach = on_attach,
      })
    end,
  },

  -- Formatter / Linter
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "gbprod/none-ls-shellcheck.nvim",
      "gbprod/none-ls-luacheck.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local mason_path = vim.fn.stdpath("data") .. "/mason/bin"

      -- Use local venv bin if exists
      local fs = vim.loop.fs_stat
      local function find_venv_bin(executable)
        local venv_path = ".venv/bin/" .. executable
        if fs(venv_path) then
          return vim.fn.getcwd() .. "/" .. venv_path
        end
        return nil
      end

      -- Check formatter config file exists in project root
      local utils = require("null-ls.utils")
      local function has_format_config(filename)
        return function()
          return vim.fn.filereadable(utils.get_root() .. "/" .. filename) == 1
        end
      end

      null_ls.setup({
        sources = {
          -- JavaScript / TypeScript / JSON / Angular
          null_ls.builtins.formatting.prettier.with({
            condition = has_format_config(".prettierrc"),
            prefer_local = "node_modules/.bin",
          }),
          -- Python import sorter
          null_ls.builtins.formatting.isort.with({
            condition = has_format_config("pyproject.toml"),
            command = find_venv_bin("isort") or "isort",
          }),
          -- Python formatter
          null_ls.builtins.formatting.yapf.with({
            condition = has_format_config("pyproject.toml"),
            command = find_venv_bin("yapf") or "yapf",
          }),
          -- Dockerfile linter
          null_ls.builtins.diagnostics.hadolint.with({
            command = mason_path .. "/hadolint",
          }),
          -- Shell linter
          require("none-ls-shellcheck.diagnostics").with({
            command = mason_path .. "/shellcheck",
          }),
          -- Lua linter
          require("none-ls-luacheck.diagnostics.luacheck").with({
            command = mason_path .. "/luacheck",
          }),
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, async = false })
              end,
            })
          end
        end,
      })
    end,
  },
}
