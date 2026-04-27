local set = vim.opt

-- Sets line numbers to relative, except for current line
set.number = true
set.relativenumber = true

-- Default indentation options. Should hopefully be overwritten
set.smarttab = true
set.autoindent = true
set.tabstop = 4
set.expandtab = false

-- Line wrapping options
set.wrap = true
set.breakindent = true
set.linebreak = true

-- Visual settings
set.scrolloff = 6
set.termguicolors = true
set.cursorline = true

-- Save undo history
set.undofile = true

vim.g.mapleader = ' '

-- Temporarily highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
