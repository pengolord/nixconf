-- guess-indent makes it so you don't need an editorconfig in every project
-- Source: https://github.com/NMAC427/guess-indent.nvim

return {
  'guess-indent.nvim',
  after = function()
    require('guess-indent').setup()
  end,
}
