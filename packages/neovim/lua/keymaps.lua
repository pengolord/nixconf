-- Remove highlights when pressing esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Disable arrow keys lol
vim.keymap.set('n', '<left>', '<cmd>echo "Don\'t even try!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Whoa there buster!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "No arrow keys for you, buddy!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "How\'re you gonna get better like that!"<CR>')
vim.keymap.set('i', '<left>', '<cmd>echo "Don\'t even try!"<CR>')
vim.keymap.set('i', '<right>', '<cmd>echo "Whoa there buster!"<CR>')
vim.keymap.set('i', '<up>', '<cmd>echo "No arrow keys for you, buddy!!"<CR>')
vim.keymap.set('i', '<down>', '<cmd>echo "How\'re you gonna get better like that!"<CR>')

-- Double escape to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Focus/Create Terminal Window
vim.keymap.set('n', '<leader>t', function()
  -- Look for an existing terminal window
  local current_terminal_window = nil
  local current_text_window = nil
  for _, window in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(window)
    if vim.bo[buf].buftype == 'terminal' then
      current_terminal_window = window
    elseif vim.bo[buf].buftype == '' then
      current_text_window = window
    end
  end

  if (current_terminal_window ~= nil) then
    vim.api.nvim_set_current_win(current_terminal_window)
  else
    vim.api.nvim_set_current_win(current_text_window)
    vim.cmd('belowright 15split | terminal')
  end
end)

-- Focus/Create file explorer
vim.keymap.set('n', '<leader>f', '<cmd>Neotree left focus<CR>')
