-- Lualine is a plugin that improves the default status bar by quite a bit.
-- Source: https://github.com/nvim-lualine/lualine.nvim

return {
  'lualine.nvim',
  lazy = false,
  after = function()
    require('lualine').setup({})
  end,
}
