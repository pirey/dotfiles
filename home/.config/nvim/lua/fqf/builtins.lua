local M = {}
local sources = require("fqf.sources")
local View = require("fqf.view")
local H = require("fqf.helpers")

-- TODO: use unified source without dependency checking
function M.files()
  local title = "Files"
  local items = {}

  if vim.fn.executable("fd") then
    items = sources.fd_files()
  elseif H.is_git_repo() then
    items = sources.git_files()
  else
    items = sources.fs_files()
  end

  local view = View:new(items, { title = title })
  view:open()
end

function M.dirs()
  local title = "Directories"
  local items = {}

  if vim.fn.executable("fd") then
    items = sources.fd_files({ fs_type = "directory" })
  elseif H.is_git_repo() then
    local files = sources.git_files()
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
    items = sources.fs_files({ fs_type = "directory" })
  end

  vim.cmd("copen")
  local view = View:new(items, { title = title })
  view:open()
end

function M.live_grep(opts)
  local title = "Search"
  local items = {}

  local view = View:new(items, {
    title = title,
    onchange = function(query)
      local lines = vim.fn.systemlist({
        "rg",
        "--hidden",
        "--vimgrep",
        "--smart-case",
        "--glob=!.git",
        query,
      })
      local filtered = {}
      for _, line in ipairs(lines) do
        local filename, lnum, col, text = line:match("^([^:]+):(%d+):(%d+):(.*)$")

        if filename then
          filtered[#filtered + 1] = {
            filename = filename,
            lnum = tonumber(lnum),
            col = tonumber(col),
            text = text,
          }
        end
      end
      return filtered
    end,
  })
  view:open()
end

function M.grep(opts)
  opts = opts or {}
  local prompt = opts.prompt or "Search: "
  local auto_open = opts.auto_open or false
  local silent = opts.silent ~= false
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

function M.buffer_grep(opts)
  local win = vim.api.nvim_get_current_win()
  opts = opts or {}
  local prompt = opts.prompt or "/"
  local use_loclist = opts.use_loclist ~= false
  local ok, query = pcall(vim.fn.input, prompt)
  if query == "" or not ok then
    return
  end
  local title = "/" .. query
  local items = {}

  local pos = { 0, 0 }
  local buf = vim.api.nvim_get_current_buf()
  local fname = vim.api.nvim_buf_get_name(buf)
  vim.cmd("normal! ms")
  vim.cmd("normal! gg")
  while true do
    pos = vim.fn.searchpos(query, "W")
    local lnum = pos[1]
    local col = pos[2]
    if lnum == 0 and col == 0 then
      break
    end
    local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
    items[#items + 1] = {
      filename = fname,
      lnum = lnum,
      col = col,
      text = line,
    }
  end
  vim.cmd("normal! 's")
  vim.cmd("delmarks s")

  vim.fn.setreg("/", query)
  if use_loclist then
    vim.fn.setloclist(win, {}, " ", { title = title, items = items })
    vim.cmd("lopen")
  else
    vim.fn.setqflist({}, " ", { title = title, items = items })
    vim.cmd("copen")
  end
end

function M.oldfiles(opts)
  opts = opts or {}
  local title = opts.title or "Oldfiles"
  local current_dir = opts.current_dir ~= false
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

  local view = View:new(items, { title = title })
  view:open()
end

function M.git_changes()
  if not H.is_git_repo() then
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

  local view = View:new(items, { title = "Git Changes" })
  view:open()
end

return M
