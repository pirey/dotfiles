local function is_git_repo()
  return vim.fn.executable("git") == 1
    and vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match("true")
end

---@param path string
---@param out string[]
---@param t string? @default "file"
local function scan(path, out, t)
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

    -- TODO: parse .gitignore
    if vim.tbl_contains(ignore_files, name) then
      goto continue
    end

    if fs_t == t then
      table.insert(out, {
        filename = fullpath,
        lnum = 1,
        col = 1,
      })
    end

    if fs_t == "directory" then
      scan(fullpath, out, t)
    end

    ::continue::
  end
end

local M = {}

function M.find_files()
  local items = {}
  if is_git_repo() then
    local lines = vim.fn.systemlist("git ls-files --cached --others --exclude-standard")
    items = vim.tbl_map(function(item)
      return { filename = item, lnum = 1, col = 1 }
    end, lines)
  else
    scan(vim.uv.cwd() or ".", items, "files")
  end

  vim.fn.setqflist({}, " ", { title = "Searching files..." })
  vim.schedule(function()
    vim.fn.setqflist({}, " ", {
      title = "Files",
      items = items,
    })
  end)
  vim.cmd("copen")
end

vim.api.nvim_create_user_command("FQF", function()
  M.find_files()
end, {})
