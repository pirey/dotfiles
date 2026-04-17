local config = require("fqf.config")

local M = {}

M.qftf = require("fqf.qftf").qftf
M.builtins = require("fqf.builtins")
M.ui_select = require("fqf.ui_select")

function M.setup(opts)
  config.opts = vim.tbl_deep_extend("force", config.default, opts or {})

  if config.opts.ui_select.enabled then
    vim.ui.select = M.ui_select
  end

  if config.opts.qftf.enabled then
    vim.o.quickfixtextfunc = "v:lua.require'fqf'.qftf"
  end
end

return M
