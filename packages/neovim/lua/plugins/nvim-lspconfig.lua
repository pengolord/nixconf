-- Nvim-lspconfig makes it significantly easier to configure language servers.
-- Source: https://github.com/neovim/nvim-lspconfig

return {
  'nvim-lspconfig',
  lazy = false,
  before = function()
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('nixd')
    vim.lsp.enable('rust_analyzer')
    vim.lsp.enable('ts_ls')
    vim.lsp.enable('java_language_server')
  end,
}
