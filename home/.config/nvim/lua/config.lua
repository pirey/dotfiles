---@class ConfigOpts
---@field use_nerd_font? boolean
---@field preset_statusline? "simple"|"bubble"|"slanted"|"slanted2"|"slanted3"|"asymmetric"|"asymmetric2"
---@field preset_incline? "simple"|"bubble"|"slanted"|"slanted2"|"slanted3"|"asymmetric"|"asymmetric2"
---@field preset_fff? "corner"|"left-right"|"top-down"

---@type ConfigOpts
local default_opts = {
  use_nerd_font = false,
  preset_statusline = nil,
  preset_incline = nil,
  preset_fff = "corner",
}

local M = {}

---@param opts? ConfigOpts
function M.setup(opts)
  opts = vim.tbl_extend('force', default_opts, opts or {})
  M.use_nerd_font = opts.use_nerd_font or vim.g.use_nerd_font
  M.preset_statusline = opts.preset_statusline or vim.g.preset_statusline
  M.preset_incline = opts.preset_incline or vim.g.preset_incline
  M.preset_fff = opts.preset_fff or vim.g.preset_fff

  M._set_options()
end

function M._set_options()
  if M.is_rounded_preset() then
    vim.o.winborder = "rounded"
    vim.o.pumborder = "rounded"
  end
end

---@return boolean
function M.is_rounded_preset()
  return vim.tbl_contains({ "bubble", "asymmetric", "asymmetric2" }, M.preset_statusline)
end

return M
