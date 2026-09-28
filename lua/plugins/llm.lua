return {
  {
    "Kurama622/llm.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = {
      "LLMSessionToggle",
      "LLMSelectedTextHandler",
      "LLMAppHandler",
    },
    keys = {
      { "<leader>ac", "<cmd>LLMSessionToggle<cr>", mode = "n", desc = "Toggle LLM chat" },
      { "<leader>ae", "<cmd>LLMAppHandler CodeExplain<cr>", mode = "x", desc = "Explain selected code" },
      { "<leader>aa", "<cmd>LLMAppHandler Ask<cr>", mode = { "n", "x" }, desc = "Ask LLM about code" },
    },
    config = function()
      local providers = {
        trend_micro = {
          env_prefix = "LLM_TREND_MICRO",
          api_type = "openai",
          models = {
            { name = "GPT-5.6 Luna", model = "gpt-5.6-luna" },
            { name = "GPT-5.6 Terra", model = "gpt-5.6-terra" },
            { name = "GPT-5.6 Luna AWS", model = "gpt-5.6-luna-aws" },
            { name = "GPT-5.6 Terra AWS", model = "gpt-5.6-terra-aws" },
            { name = "Claude 4.6 Sonnet", model = "claude-4.6-sonnet-aws" },
            { name = "Claude 4.8 Opus", model = "claude-4.8-opus-aws" },
            { name = "Gemini 3.1 Pro", model = "gemini-3.1-pro" },
            { name = "Gemini 3.7 Flash", model = "gemini-3.7-flash" },
          },
        },
      }

      local allowed_env = {}
      for _, config in pairs(providers) do
        allowed_env[config.env_prefix .. "_API"] = true
        if config.key_required ~= false then
          allowed_env[config.env_prefix .. "_KEY"] = true
        end
      end

      local env_path = vim.fn.stdpath("config") .. "/.env"

      -- Only load API and key variables for configured providers.
      if vim.fn.filereadable(env_path) == 1 then
        for _, line in ipairs(vim.fn.readfile(env_path)) do
          local key, value = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
          if key and allowed_env[key] then
            value = value:gsub('^(["\'])(.*)%1$', "%2")
            vim.env[key] = value
          end
        end
      end

      local function provider_models(config)
        local api = vim.env[config.env_prefix .. "_API"]
        local key = vim.env[config.env_prefix .. "_KEY"]

        if not api or (config.key_required ~= false and not key) then
          vim.notify(
            "Missing " .. config.env_prefix .. "_API"
              .. (config.key_required ~= false and " or " .. config.env_prefix .. "_KEY" or "")
              .. "; provider disabled",
            vim.log.levels.WARN
          )
          return {}
        end

        local models = {}
        for _, item in ipairs(config.models) do
          table.insert(models, {
            name = item.name,
            model = item.model,
            url = api,
            api_type = config.api_type,
            fetch_key = config.key_required == false and "NONE" or function()
              return vim.env[config.env_prefix .. "_KEY"]
            end,
          })
        end

        return models
      end

      local models = {}
      for _, config in pairs(providers) do
        vim.list_extend(models, provider_models(config))
      end

      require("llm").setup({
        models = models,
        app_handler = {
          CodeExplain = {
            handler = "flexi_handler",
            prompt = "Explain the following code. Return only the explanation in Traditional Chinese (繁體中文), using Taiwan terminology.",
            opts = {
              language = "Traditional Chinese (繁體中文)",
              enter_flexible_window = true,
            },
          },

          Ask = {
            handler = "disposable_ask_handler",
            opts = {
              enable_buffer_context = true,
              language = "Traditional Chinese (繁體中文)",
              inline_assistant = true,
              display = {
                mapping = {
                  mode = "n",
                  keys = { "d" },
                },
              },
              accept = {
                mapping = {
                  mode = "n",
                  keys = { "y", "Y" },
                },
              },
              reject = {
                mapping = {
                  mode = "n",
                  keys = { "n", "N" },
                },
              },
              close = {
                mapping = {
                  mode = "n",
                  keys = { "<Esc>" },
                },
              },
            },
          },
        },
      })
    end,
  },
}
