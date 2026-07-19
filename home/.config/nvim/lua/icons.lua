local config = require("config")
local M = {}

function M.init()
  M.enabled = config.opts.enable_icons
end

M.registry = {
  branch = { icon = "", fallback = "⎇ " },
  folder = { icon = "󰉋 ", fallback = "" },
  error = { icon = " ", fallback = "● " },
  warn = { icon = " ", fallback = "● " },
  info = { icon = " ", fallback = "● " },
  hint = { icon = " ", fallback = "● " },
  fold_closed = { icon = "", fallback = "›" },
  fold_open = { icon = "", fallback = "⌄" },
  modified = { icon = "●", fallback = "[+]" },
  readonly = { icon = "", fallback = "[-]" },
}

function M.get(name)
  local entry = M.registry[name]
  if not entry then
    return ""
  end
  return M.enabled and entry.icon or entry.fallback
end

function M.diagnostics_symbols()
  return {
    error = M.get("error"),
    warn = M.get("warn"),
    info = M.get("info"),
    hint = M.get("hint"),
  }
end

M.separators = {
  arrow_right_filled = { icon = "", fallback = "" },
  arrow_right_thin = { icon = "", fallback = "" },
  arrow_left_filled = { icon = "", fallback = "" },
  arrow_left_thin = { icon = "", fallback = "" },
  chevron_right_thin = { icon = "", fallback = ">" },
  round_right_filled = { icon = "", fallback = "" },
  round_right_thin = { icon = "", fallback = "" },
  round_left_filled = { icon = "", fallback = "" },
  round_left_thin = { icon = "", fallback = "" },
  slant_right_filled = { icon = "", fallback = "" },
  slant_left_filled = { icon = "", fallback = "" },
  slant_right_upper = { icon = "", fallback = "" },
  slant_left_upper = { icon = "", fallback = "" },
  slant_left_thin = { icon = "", fallback = "" },
  slant_right_thin = { icon = "", fallback = "" },
  bar_thick = { icon = "╏", fallback = "" },
  bar_thin = { icon = "│", fallback = "" },
}

function M.sep(name)
  local entry = M.separators[name]
  if not entry then
    return ""
  end
  return M.enabled and entry.icon or entry.fallback
end

M.init()
return M
