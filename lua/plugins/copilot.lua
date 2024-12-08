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
                        accept = "<tab>",
                        accept_word = "<A-w>",
                        accept_line = "<A-l>",
                    },
                }
            })
        end,
    },
    {
        "yetone/avante.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "muniftanjim/nui.nvim",
            {
                "meanderingprogrammer/render-markdown.nvim",
                opts = { file_types = { "markdown", "avante" } },
                ft = { "markdown", "avante" },
            },
        },
        build = "make",
        config = function()
            local opts = { provider = "copilot" }
            require("avante").setup(opts)
        end,
    },
}
