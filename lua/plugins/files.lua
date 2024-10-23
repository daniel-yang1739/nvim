return {
    {
        -- File Explorer --
        "preservim/nerdtree",
        lazy = false,
        keys = {
            { "<leader>n", "<cmd>NERDTreeToggle<cr>", desc = "nerdtree toggle" },
        },
        config = function()
            -- Read the argument stdin
            vim.api.nvim_create_autocmd("StdinReadPre", {
                callback = function()
                    vim.g.std_in = true
                end,
            })

            -- open NERDTree if no specified file when open nvim
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    if vim.fn.argc() == 0 and vim.g.std_in == nil then
                        vim.defer_fn(function()
                            vim.cmd("NERDTree")
                        end, 10)
                    end
                end,
            })

            -- Close NERDTree when open a file
            vim.g.NERDTreeQuitOnOpen = true
        end
    },
    {
        -- Find Files --
        "ctrlpvim/ctrlp.vim",
        config = function()
            -- Set wildignore patterns
            vim.o.wildignore = vim.o.wildignore .. '/tmp/,.so,.swp,.zip,.,env,*.pyc'

            if vim.fn.executable('ag') then
                -- Use Ag in CtrlP for listing files. Lightning fast and respects .gitignore
                vim.g.ctrlp_user_command = 'ag %s --skip-vcs-ignores --ignore-dir=node_modules --ignore-dir=__pycache__ -l -g ""'

                -- Set Ag as the grepprg
                vim.o.grepprg = 'ag --nogroup --nocolor'
            end
        end
    },
--[[  disable telescope
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
                    layout_config = {
                        width = 0.6,
                        height = 0.5,
                    },
                    --  disable file preview
                    preview = {
                        hide_on_startup = true,
                    },
                }
            }
        end
    },
]]--
}
