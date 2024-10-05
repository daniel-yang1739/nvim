return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = "Telescope",
        keys = {
            { "<C-p>", "<cmd>Telescope find_files disable_devicons=true<cr>", desc = "find files" }
        },
        opts = function()
            return {
                defaults = {
                    file_ignore_patterns = { "__pycache__", "node_modules", ".git" },
                }
            }
        end
    },
}
