-- Some Pre-built colorschemes as well as support for my matugen pallete.
-- Source: https://github.com/RRethy/base16-nvim

return {
  'base16-nvim',
  after = function()
    local path = vim.fn.expand("~/.cache/matugen/neovim.lua")
    if vim.loop.fs_stat(path) then
      local ok, mod_or_err = pcall(dofile, path)
      if not ok then
        vim.notify("Error loading " .. path .. ": " .. tostring(err), vim.log.levels.ERROR)
        return
      end

      local mod = mod_or_err
      local fn = function() return mod.setup() end

      local ok2, err2 = xpcall(fn, debug.traceback)
      if not ok2 then
        vim.notify("Error running setup of " .. path .. ": " .. tostring(err), vim.log.levels.ERROR)
        return
      end
    else
      vim.notify("Matugen config not found: " .. path, vim.log.levels.WARN)
    end
  end,
}
