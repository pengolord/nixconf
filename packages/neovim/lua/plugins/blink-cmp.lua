-- Blink.cmp gives a nice little autocomplete menu.
-- Source: https://github.com/Saghen/blink.cmp

return {
  'blink.cmp',
  lazy = false,
  after = function()
    require('blink.cmp').setup({
      keymap = {
        preset = 'super-tab',
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
	  })
  end,
}
