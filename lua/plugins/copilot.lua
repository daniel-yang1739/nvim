return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<A-tab>",
            accept_word = "<A-w>",
            accept_line = "<A-l>",
          },
        }
      })
    end,
  },
}
