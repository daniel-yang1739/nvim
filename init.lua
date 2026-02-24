vim.loader.enable()  -- speedup nvim
require("config.autocmds")
require("config.keymaps")
require("config.lazy")
require("config.options")

-- transparent the backgroung color to terminal
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- NC = Non-Current window

local colors = require('constant.colors')
vim.api.nvim_set_hl(0, 'GitSignsAddNr',    { fg = colors.git.add, bold = true })
vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { fg = colors.git.change, bold = true })
vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { fg = colors.git.delete, bold = true })
