local View = require("fqf.view")
local H = require("fqf.helpers")

local sources = {}

-- ── source functions ──────────────────────────────────────────────────────────

function sources.fs_files(opts)
  opts = opts or {}
  local t = opts.fs_type or "file"
  local items = {}
  H.fs_scan(vim.uv.cwd() or ".", items, t)
  return items
end

function sources.fd_files(opts)
  opts = opts or {}
  local t = opts.fs_type or "file"
  local lines = vim.fn.systemlist({
    "fd", "--hidden", "--exclude", ".git",
    "--type", t == "file" and "f" or "d",
  })
  local items = {}
  for i = 1, #lines do
    items[#items + 1] = { filename = lines[i], lnum = 1, col = 1 }
  end
  return items
end

function sources.git_files()
  if not H.is_git_repo() then return {} end
  local lines = vim.fn.systemlist("git ls-files --cached --others --exclude-standard")
  if vim.v.shell_error ~= 0 then return {} end
  local items = {}
  for i = 1, #lines do
    items[#items + 1] = { filename = lines[i], lnum = 1, col = 1 }
  end
  return items
end

function sources.git_changes()
  if not H.is_git_repo() then return {} end
  local lines = vim.fn.systemlist("git status --porcelain")
  local items = {}
  for _, line in ipairs(lines) do
    local status, file = line:match("^(..)%s+(.*)$")
    if status and file then
      local staged, unstaged = status:sub(1, 1), status:sub(2, 2)
      -- handle renames "old -> new"
      file = file:match("^.+ %-> (.+)$") or file
      items[#items + 1] = {
        filename = vim.trim(file),
        lnum = 1,
        col = 1,
        text = staged ~= " " and staged or unstaged,
      }
    end
  end
  return items
end

function sources.oldfiles(opts)
  opts = opts or {}
  local current_dir = opts.current_dir ~= false
  local cwd = vim.uv.cwd() or ""
  local items = {}
  for _, path in ipairs(vim.v.oldfiles) do
    if (not current_dir or path:find(cwd, 1, true) == 1) and vim.uv.fs_stat(path) then
      items[#items + 1] = {
        filename = vim.fn.fnamemodify(path, ":."),
        lnum = 1,
        col = 1,
      }
    end
  end
  return items
end

-- ── helpers ───────────────────────────────────────────────────────────────────

-- Merges multiple source item lists into one, deduplicating by filename.
-- Order of first appearance is preserved.
local function merge_sources(source_lists)
  local seen = {}
  local merged = {}
  for _, list in ipairs(source_lists) do
    for _, item in ipairs(list) do
      if not seen[item.filename] then
        seen[item.filename] = true
        merged[#merged + 1] = item
      end
    end
  end
  return merged
end

-- Wraps matchfuzzy to preserve the original source order among results.
-- Without this, matchfuzzy reorders by score, losing the priority of sources.
local function ordered_fuzzy(items, query, opts)
  if #query == 0 then return items end
  local results = vim.fn.matchfuzzy(items, query, opts)
  -- build a rank map from the original list
  local rank = {}
  for i, item in ipairs(items) do
    rank[item.filename] = i
  end
  table.sort(results, function(a, b)
    return (rank[a.filename] or math.huge) < (rank[b.filename] or math.huge)
  end)
  return results
end

-- ── pickers ───────────────────────────────────────────────────────────────────
local builtins = {}

function builtins.files()
  local items = {}
  if vim.fn.executable("fd") then
    items = sources.fd_files()
  elseif H.is_git_repo() then
    items = sources.git_files()
  else
    items = sources.fs_files()
  end
  View:new(items, { title = "Files" }):open()
end

function builtins.dirs()
  local items = {}
  if vim.fn.executable("fd") then
    items = sources.fd_files({ fs_type = "directory" })
  elseif H.is_git_repo() then
    local files = sources.git_files()
    local seen = {}
    for _, f in ipairs(files) do
      local dir = f.filename:match("(.+)/[^/]+$")
      while dir do
        if not seen[dir] then
          seen[dir] = true
          items[#items + 1] = { filename = dir, lnum = 1, col = 1 }
        end
        dir = dir:match("(.+)/[^/]+$")
      end
    end
  else
    items = sources.fs_files({ fs_type = "directory" })
  end
  vim.cmd("copen")
  View:new(items, { title = "Directories" }):open()
end

function builtins.live_grep()
  local current_job = nil
  View:new({}, {
    title = "Search",
    filter_debounce = 200,
    chunk_size = nil,
    on_change = function(query, done)
      if current_job then
        current_job:kill(9)
        current_job = nil
      end
      if #query < 3 then
        done({})
        return
      end
      current_job = vim.system(
        { "rg", "--hidden", "--vimgrep", "--smart-case", "--fixed-strings", "--glob=!.git", query },
        { text = true },
        vim.schedule_wrap(function(obj)
          current_job = nil
          if not obj or obj.signal ~= 0 or obj.code ~= 0 then return end
          local filtered = {}
          for line in (obj.stdout or ""):gmatch("[^\n]+") do
            local filename, lnum, col, text = line:match("^([^:]+):(%d+):(%d+):(.*)$")
            if filename then
              filtered[#filtered + 1] = {
                filename = filename, lnum = tonumber(lnum),
                col = tonumber(col), text = text,
              }
            end
          end
          done(filtered)
        end)
      )
    end,
  }):open()
end

function builtins.grep(opts)
  opts = opts or {}
  local ok, query = pcall(vim.fn.input, opts.prompt or "Search: ")
  if not ok or query == "" then return end
  vim.defer_fn(function()
    local silent = opts.silent ~= false
    local auto_open = opts.auto_open or false
    vim.cmd(string.format("%sgrep%s '%s'", silent and "silent " or "", auto_open and "" or "!", query))
    vim.cmd("copen")
    vim.fn.setqflist({}, "a", { title = "Search: " .. query })
    vim.fn.setreg("/", query)
    pcall(function(args) vim.cmd(args) end, "normal! n")
  end, 0)
end

function builtins.buffer_lines()
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local filename = vim.api.nvim_buf_get_name(buf)
  local items = {}
  for i = 1, #lines do
    if vim.trim(lines[i]) ~= "" then
      items[#items + 1] = { filename = filename, text = lines[i], lnum = i, col = 1 }
    end
  end
  View:new(items, {
    title = "Search",
    filter_by = "text",
    use_lwin = true,
    onselect = function(item)
      vim.api.nvim_win_set_cursor(win, { item.lnum, 1 })
    end,
  }):open()
end

function builtins.oldfiles(opts)
  opts = opts or {}
  local items = sources.oldfiles({ current_dir = opts.current_dir })
  View:new(items, { title = opts.title or "Oldfiles" }):open()
end

function builtins.git_changes()
  if not H.is_git_repo() then return end
  local items = sources.git_changes()
  View:new(items, { title = "Git Changes" }):open()
end

function builtins.smart_files()
  if not H.is_git_repo() then
    View:new(sources.fd_files(), { title = "Files" }):open()
    return
  end

  local merged = merge_sources({
    sources.git_changes(),
    sources.oldfiles(),
    sources.fd_files(),
  })

  View:new(merged, {
    title = "Smart Files",
    on_change = function(query, done)
      done(ordered_fuzzy(merged, query, { key = "filename" }))
    end,
  }):open()
end

return builtins
