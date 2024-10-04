return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "Telescope",
    keys = {
        { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "find files" }
    },
}
