---@param path string
---@param items string[]
---@param t string? @default "file"
local function scan_files(path, items, t)
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
      table.insert(items, {
        filename = fullpath,
        lnum = 1,
        col = 1,
      })
    end

    if fs_t == "directory" then
      scan_files(fullpath, items, t)
    end

    ::continue::
  end
end

local CHUNK_SIZE = 100
local ITEMS_DELAY = 10

local M = {}
M.builtins = {}

function M.builtins.find_files()
  local title_loading = "Loading..."
  local title = "Files"
  local items = {}

  scan_files(vim.uv.cwd() or ".", items, "file")

  vim.cmd("copen")
  vim.fn.setqflist({}, " ", { title = title_loading })

  local function add_chunk(idx)
    local chunk = vim.list_slice(items, idx, math.min(idx + CHUNK_SIZE - 1, #items))
    vim.fn.setqflist({}, "a", { items = chunk })
    idx = idx + CHUNK_SIZE
    if idx <= #items then
      vim.defer_fn(function()
        add_chunk(idx)
      end, ITEMS_DELAY)
    else
      vim.fn.setqflist({}, "a", { title = title })
    end
  end

  vim.defer_fn(function()
    add_chunk(1)
  end, 0)
end

function M.builtins.find_dirs()
end

vim.api.nvim_create_user_command("FQF", function()
  M.builtins.find_files()
end, {})
