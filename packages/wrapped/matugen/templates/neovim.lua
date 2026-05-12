# Taken from https://docs.noctalia.dev/theming/program-specific/neovim
local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Background tones
    base00 = '{{colors.surface.default.hex}}', -- Default Background
    base01 = '{{colors.surface_container.default.hex}}', -- Lighter Background (status bars)
    base02 = '{{colors.surface_container_high.default.hex}}', -- Selection Background
    base03 = '{{colors.outline.default.hex}}', -- Comments, Invisibles
    -- Foreground tones
    base04 = '{{colors.on_surface_variant.default.hex}}', -- Dark Foreground (status bars)
    base05 = '{{colors.on_surface.default.hex}}', -- Default Foreground
    base06 = '{{colors.on_surface.default.hex}}', -- Light Foreground
    base07 = '{{colors.on_background.default.hex}}', -- Lightest Foreground
    -- Accent colors
    base08 = '{{colors.error.default.hex}}', -- Variables, XML Tags, Errors
    base09 = '{{colors.tertiary_fixed_dim.default.hex}}', -- Integers, Constants
    base0A = '{{colors.tertiary.default.hex}}', -- Classes, Search Background
    base0B = '{{colors.primary.default.hex}}', -- Strings, Diff Inserted
    base0C = '{{colors.primary_fixed_dim.default.hex}}', -- Regex, Escape Chars
    base0D = '{{colors.secondary.default.hex}}', -- Functions, Methods
    base0E = '{{colors.secondary_fixed_dim.default.hex}}', -- Keywords, Storage
    base0F = '{{colors.inverse_primary.default.hex}}', -- Deprecated, Embedded Tags
  }
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
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
  end)
)

return M
