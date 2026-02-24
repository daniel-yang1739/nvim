local M = {}

local function get_fg(name)
    local hl = vim.api.nvim_get_hl(0, { name = name, link = true })
    if hl and hl.fg then
        return string.format('#%06x', hl.fg)
    end
    return '#FF00FF'
end

M.git = {
  add    = get_fg('DiagnosticOk'),
  change = get_fg('DiagnosticInfo'),
  delete = get_fg('DiagnosticError'),
}

return M
