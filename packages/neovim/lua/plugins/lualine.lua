-- Lualine is a plugin that improves the default status bar by quite a bit.
-- Source: https://github.com/nvim-lualine/lualine.nvim

return {
  'lualine.nvim',
  lazy = false,
  after = function()
    require('lualine').setup {
      options = {
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { { 'mode', right_padding = 2 } },
        lualine_b = { 'filename', 'branch' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'filetype', 'diff' },
        lualine_z = { { 'location', left_padding = 2 } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { 'filename' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    }
  end,
}
