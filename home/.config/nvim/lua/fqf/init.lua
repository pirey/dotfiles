local M = {}

M.qftf = require("fqf.qftf").qftf
M.builtins = require("fqf.builtins")
M.ui_select = require("fqf.ui_select")

function M.setup(opts)
  opts = opts or {}
  local register_ui_select = opts.register_ui_select ~= false
  local register_quickfixtextfunc = opts.register_quickfixtextfunc ~= false

  if register_ui_select then
    vim.ui.select = M.ui_select
  end

  if register_quickfixtextfunc then
    vim.o.quickfixtextfunc = "v:lua.require'fqf'.qftf"
  end
end

return M
