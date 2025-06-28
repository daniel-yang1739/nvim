return {
  -- Installer
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },

  -- Mason Tool Installer
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    build = ":MasonToolsUpdate",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",    -- JS/TS Formatter
          "isort",       -- Python Import Sorter
          "yapf",        -- Python Formatter
          "shellcheck",  -- Shell Linter
          "hadolint",    -- Docker/Haskell Linter
          "luacheck",    -- Lua Linter
        },
        -- if set to true this will check each tool for updates. If updates
        -- are available the tool will be updated. This setting does not
        -- affect :MasonToolsUpdate or :MasonToolsInstall.
        -- Default: false
        auto_update = false,

        -- automatically install / update on startup. If set to false nothing
        -- will happen on startup. You can use :MasonToolsInstall or
        -- :MasonToolsUpdate to install tools and check for updates.
        -- Default: true
        run_on_start = true,

        -- set a delay (in ms) before the installation starts. This is only
        -- effective if run_on_start is set to true.
        -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
        -- Default: 0
        start_delay = 3000, -- 3 second delay

        -- Only attempt to install if 'debounce_hours' number of hours has
        -- elapsed since the last time Neovim was started. This stores a
        -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
        -- This is only relevant when you are using 'run_on_start'. It has no
        -- effect when running manually via ':MasonToolsInstall' etc....
        -- Default: nil
        debounce_hours = 5, -- at least 5 hours between attempts to install/update

        -- By default all integrations are enabled. If you turn on an integration
        -- and you have the required module(s) installed this means you can use
        -- alternative names, supplied by the modules, for the thing that you want
        -- to install. If you turn off the integration (by setting it to false) you
        -- cannot use these alternative names. It also suppresses loading of those
        -- module(s) (assuming any are installed) which is sometimes wanted when
        -- doing lazy loading.
        integrations = {
          ['mason-lspconfig'] = false,  -- Due to conflict with tsserver naming
          ['mason-null-ls'] = true,
          ['mason-nvim-dap'] = true,
        },
      })
    end,
  },

  -- LSP Installer
  {
    "williamboman/mason-lspconfig.nvim",
    version = "1.32.0",  -- for Failed: attempt to call field 'enable'
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
