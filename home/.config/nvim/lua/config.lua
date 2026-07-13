---@class ConfigOpts
---@field use_nerd_font? boolean
---@field cmdline_completion? boolean
---@field preset_statusline? "simple"|"bubble"|"slanted"|"slanted2"|"slanted3"|"asymmetric"|"asymmetric2"
---@field preset_incline? "simple"|"bubble"|"slanted"|"slanted2"|"slanted3"|"asymmetric"|"asymmetric2"
---@field preset_fff? "corner"|"horizontal"|"vertical"

---@type ConfigOpts
local default_opts = {
  use_nerd_font = false,
  cmdline_completion = false,
  preset_statusline = nil,
  preset_incline = nil,
  preset_fff = nil,
}

---@class ConfigModule
---@field opts ConfigOpts
---@field setup fun(opts?: ConfigOpts)
---@field _set_options fun()
---@field is_rounded_preset fun(): boolean

---@type ConfigModule
local M = {
  opts = {
    use_nerd_font = false,
    cmdline_completion = false,
    preset_statusline = nil,
    preset_incline = nil,
    preset_fff = "corner",
  },
  setup = function() end,
  _set_options = function() end,
  is_rounded_preset = function() return false end,
}

---@param opts? ConfigOpts
function M.setup(opts)
  M.opts = vim.tbl_extend('force', default_opts, opts or {})
  M.opts.use_nerd_font = M.opts.use_nerd_font or vim.g.use_nerd_font
  M.opts.cmdline_completion = M.opts.cmdline_completion or vim.g.cmdline_completion
  M.opts.preset_statusline = M.opts.preset_statusline or vim.g.preset_statusline
  M.opts.preset_incline = M.opts.preset_incline or vim.g.preset_incline
  M.opts.preset_fff = M.opts.preset_fff or vim.g.preset_fff
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
  return vim.tbl_contains({ "bubble", "asymmetric", "asymmetric2" }, M.opts.preset_statusline)
end

return M
