---@class StatuslineConfig
---@field provider "lualine"
---@field preset "flat"|"simple"|"bubble"|"slanted"|"slanted2"|"slanted3"|"asymmetric"|"asymmetric2"

---@class WinbarConfig
---@field provider "incline"|"lualine"
---@field preset? "flat"|"simple"|"bubble"|"slanted"|"slanted2"|"slanted3"|"asymmetric"|"asymmetric2"

---@class BreadcrumbsConfig
---@field provider "navic"
---@field placement "statusline"|"winbar"

---@class FilePickerConfig
---@field provider "fff"
---@field preset "corner"|"horizontal"|"vertical"

---@class ConfigOpts
---@field enable_icons? boolean
---@field enable_cmdline_completion? boolean
---@field statusline? StatuslineConfig
---@field winbar? WinbarConfig
---@field file_picker? FilePickerConfig
---@field breadcrumbs? BreadcrumbsConfig

---@type ConfigOpts
local default_opts = {
  enable_icons = false,
  enable_cmdline_completion = false,
  statusline = nil,
  winbar = nil,
  file_picker = nil,
  breadcrumbs = nil,
}

---@class ConfigModule
---@field opts ConfigOpts
---@field setup fun(opts?: ConfigOpts)
---@field _set_options fun()
---@field is_rounded_preset fun(): boolean

---@type ConfigModule
local M = {
  opts = {
    enable_icons = false,
    enable_cmdline_completion = false,
    statusline = nil,
    winbar = nil,
    file_picker = nil,
    breadcrumbs = nil,
  },
  setup = function() end,
  _set_options = function() end,
  is_rounded_preset = function() return false end,
}

---@param opts? ConfigOpts
function M.setup(opts)
  M.opts = vim.tbl_extend('force', default_opts, opts or {})
  M.opts.enable_icons = M.opts.enable_icons or vim.g.enable_icons
  M.opts.enable_cmdline_completion = M.opts.enable_cmdline_completion or vim.g.enable_cmdline_completion
  M._set_options()
end

function M._set_options()
  if M.is_rounded_preset() then
    vim.o.winborder = "rounded"
    vim.o.pumborder = "rounded"
  else
    vim.o.winborder = "single"
    vim.o.pumborder = "single"
  end
end

---@return boolean
function M.is_rounded_preset()
  local preset = M.opts.statusline and M.opts.statusline.preset
  return preset and vim.tbl_contains({ "bubble", "asymmetric", "asymmetric2" }, preset) or false
end

return M
