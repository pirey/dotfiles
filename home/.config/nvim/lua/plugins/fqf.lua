local M = {}
M.builtins = {}
M.render = {}
M.source = {}
M.fs = {}

local function is_git_repo()
  if vim.fn.executable("git") ~= 1 then
    return false
  end

  vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
  return vim.v.shell_error == 0
end

---@param path string
---@param items string[]
---@param t string? @default "file"
function M.fs.scan(path, items, t)
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
      M.fs.scan(fullpath, items, t)
    end

    ::continue::
  end
end

function M.source.fs_files(opts)
  opts = opts or {}
  local t = opts.fs_type or "file"
  local items = {}
  M.fs.scan(vim.uv.cwd() or ".", items, t)
  return items
end

function M.source.git_files()
  if not is_git_repo() then
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

M.render.default_opts = {
  chunk_size = 100,
  items_delay = 10,
  init_idx = 1,
  title = "Files",
}

function M.render.make_chunk_render(items, opts)
  opts = vim.tbl_extend("force", M.render.default_opts, opts or {})
  local idx = opts.init_idx
  local title = opts.title
  local CHUNK_SIZE = opts.chunk_size
  local ITEMS_DELAY = opts.items_delay

  local function render_chunk()
    local chunk = vim.list_slice(items, idx, math.min(idx + CHUNK_SIZE - 1, #items))
    vim.fn.setqflist({}, "a", { items = chunk })
    idx = idx + CHUNK_SIZE
    if idx <= #items then
      vim.defer_fn(function()
        render_chunk()
      end, ITEMS_DELAY)
    else
      vim.fn.setqflist({}, "a", { title = title })
    end
  end

  return render_chunk
end

function M.builtins.find_files()
  local title_loading = "Loading..."
  local title = "Files"
  local items = {}

  if is_git_repo() then
    items = M.source.git_files()
  else
    items = M.source.fs_files()
  end

  vim.cmd("copen")
  vim.fn.setqflist({}, " ", { title = title_loading })

  vim.defer_fn(M.render.make_chunk_render(items, { title = title }), 0)
end

function M.builtins.find_dirs()
  local title_loading = "Loading..."
  local title = "Directories"
  local items = {}

  if is_git_repo() then
    local files = M.source.git_files()
    if not files then
      return
    end

    local seen = {}

    for _, f in ipairs(files) do
      local dir = f.filename:match("(.+)/[^/]+$")
      while dir do
        if not seen[dir] then
          seen[dir] = true
          items[#items + 1] = {
            filename = dir,
            lnum = 1,
            col = 1,
          }
        end

        dir = dir:match("(.+)/[^/]+$")
      end
    end
  else
    items = M.source.fs_files({ fs_type = "directory" })
  end

  vim.cmd("copen")
  vim.fn.setqflist({}, " ", { title = title_loading })

  vim.defer_fn(M.render.make_chunk_render(items, { title = title }), 0)
end

function M.builtins.grep(opts)
  opts = opts or {}
  local prompt = opts.prompt or "Search: "
  local auto_open = opts.auto_open or false
  local silent = opts.silent or true
  local ok, query = pcall(vim.fn.input, prompt)
  if query == "" or not ok then
    return
  end
  local title = "Search: " .. query

  vim.defer_fn(function()
    local grep_cmd_string =
      string.format("%s%s%s '%s'", silent and "silent " or "", "grep", auto_open and "" or "!", query)
    vim.cmd(grep_cmd_string)
    vim.cmd("copen")
    vim.fn.setqflist({}, "a", { title = title })
    vim.fn.setreg("/", query)
    pcall(function(args)
      vim.cmd(args)
    end, "normal! n")
  end, 0)
end

function M.builtins.oldfiles(opts)
  opts = opts or {}
  local title = opts.title or "Oldfiles"
  local current_dir = opts.current_dir or true
  local cwd = vim.uv.cwd() or ""

  local items = {}

  for _, path in ipairs(vim.v.oldfiles) do
    if not current_dir or path:find(cwd, 1, true) == 1 then
      items[#items + 1] = {
        filename = path,
        lnum = 1,
        col = 1,
      }
    end
  end

  vim.fn.setqflist({}, " ", { items = items, title = title })
  vim.cmd("copen")
end

function M.builtins.git_changes()
  if not is_git_repo() then
    return
  end

  local lines = vim.fn.systemlist("git status --porcelain")

  local items = {}

  for _, line in ipairs(lines) do
    local status, file = line:match("^(..)%s+(.*)$")
    if status and file then
      local staged = status:sub(1, 1)
      local unstaged = status:sub(2, 2)

      local st = staged ~= " " and staged or unstaged

      items[#items + 1] = {
        filename = file,
        lnum = 1,
        col = 1,
        text = st,
      }
    end
  end

  vim.fn.setqflist({}, "r", {
    title = "Git Changes",
    items = items,
  })

  vim.cmd("copen")
end

function M.setup()
  vim.api.nvim_create_user_command("FQF", function()
    M.builtins.find_files()
  end, {})
end

return M
