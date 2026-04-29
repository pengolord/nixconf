-- Smart splits makes window splitting actually usable
-- Source: https://github.com/mrjones2014/smart-splits.nvim

return {
  'smart-splits.nvim',
  lazy = false,
  after = function()
    -- Window Resizing
    vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
    vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
    vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
    vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
    -- Window Navigation
    vim.keymap.set('n', '<leader>h', require('smart-splits').move_cursor_left)
    vim.keymap.set('n', '<leader>j', require('smart-splits').move_cursor_down)
    vim.keymap.set('n', '<leader>k', require('smart-splits').move_cursor_up)
    vim.keymap.set('n', '<leader>l', require('smart-splits').move_cursor_right)
    vim.keymap.set('n', '<leader><Tab>', require('smart-splits').move_cursor_previous)
  end,
}
