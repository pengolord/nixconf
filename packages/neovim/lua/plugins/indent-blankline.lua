-- Makes it significantly easier to tell what indentation levels are what
-- Source: https://github.com/lukas-reineke/indent-blankline.nvim

return {
  'indent-blankline.nvim',
  lazy = false,
  after = function()
    require("ibl").setup({
      indent = {
        highlight = {
          "Comment"
        }
      }
    })
  end,
}
