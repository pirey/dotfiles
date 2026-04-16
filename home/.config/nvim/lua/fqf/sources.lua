local H = require("fqf.helpers")
local M = {}

function M.fs_files(opts)
  opts = opts or {}
  local t = opts.fs_type or "file"
  local items = {}
  H.fs_scan(vim.uv.cwd() or ".", items, t)
  return items
end

function M.fd_files(opts)
  opts = opts or {}
  local t = opts.fs_type or "file"
  local lines = vim.fn.systemlist({
    "fd",
    "--hidden",
    "--exclude",
    ".git",
    "--type",
    t == "file" and "f" or "d",
  })

  local items = {}
  for i = 1, #lines do
    items[#items + 1] = {
      filename = lines[i],
      lnum = 1,
      col = 1,
    }
  end

  return items
end

function M.git_files()
  if not H.is_git_repo() then
    return {}
  end

  local lines = vim.fn.systemlist("git ls-files --cached --others --exclude-standard")

  if vim.v.shell_error ~= 0 then
    return {}
  end

  local items = {}

  for i = 1, #lines do
    items[#items + 1] = {
      filename = lines[i],
      lnum = 1,
      col = 1,
    }
  end

  return items
end

return M
