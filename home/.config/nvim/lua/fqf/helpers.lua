local H = {}

-- TODO: preview
-- TODO: attach to quickfix :copen

function H.is_git_repo()
  if vim.fn.executable("git") ~= 1 then
    return false
  end

  vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
  return vim.v.shell_error == 0
end

---@param path string
---@param items string[]
---@param t string? @default "file"
function H.fs_scan(path, items, t)
  local max_items = 1000
  -- simple fix to prevent crash for now
  if #items >= max_items then
    return
  end
  local ignore_files = { ".git" }
  t = t or "file"
  local handle = vim.uv.fs_scandir(path)
  if not handle then
    return
  end
  while true do
    local name, fs_t = vim.uv.fs_scandir_next(handle)

    if not name then
      break
    end

    local fullpath = path .. "/" .. name

    if vim.tbl_contains(ignore_files, name) then
      goto continue
    end

    if fs_t == t then
      table.insert(items, {
        filename = fullpath,
        lnum = 1,
        col = 1,
      })
    end

    if fs_t == "directory" then
      H.fs_scan(fullpath, items, t)
    end

    ::continue::
  end
end

return H
