local M = {}

function M.init()
  M.enabled = vim.g.use_nerd_font ~= false
end

M.registry = {
  branch = { icon = "", fallback = "⎇ " },
  folder = { icon = "󰉋 ", fallback = "▸ " },
  error = { icon = " ", fallback = "● " },
  warn = { icon = " ", fallback = "● " },
  info = { icon = " ", fallback = "● " },
  hint = { icon = " ", fallback = "● " },
  fold_closed = { icon = "", fallback = "›" },
  fold_open = { icon = "", fallback = "⌄" },
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

M.init()
return M
