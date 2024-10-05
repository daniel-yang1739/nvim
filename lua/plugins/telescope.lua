return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = "Telescope",
        keys = {
            { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "find files" }
        },
        opts = function()
            return {
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git" },
                }
            }
        end
    },
}
