local M = {}

local function get_fg(name, fallback)
    local hl = vim.api.nvim_get_hl(0, { name = name, link = true })
    if hl and hl.fg then
        return string.format('#%06x', hl.fg)
    end
    return fallback
end

M.git = {
  add    = get_fg('DiagnosticOk',    '#A3BE8C'),
  change = get_fg('DiagnosticInfo',  '#7AA2F7'),
  delete = get_fg('DiagnosticError', '#BF616A'),
}

return M
