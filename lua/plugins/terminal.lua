return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      size = 60,
      open_mapping = [[<c-\>]],
      direction = 'float',  -- 'horizontal' | 'vertical' | 'tab' | 'float'
      float_opts = {
        border = 'curved',  -- 'single' | 'double' | 'shadow' | 'curved' | 'none'
        winblend = 3,       -- Transparency level
        width = 120,       -- Width of the floating terminal
        height = 35,      -- Height of the floating terminal
      },
    }
  }
}
