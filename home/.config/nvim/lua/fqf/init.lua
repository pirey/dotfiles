local M = {}
M.builtins = {}
M.render = {}
M.source = {}
M.fs = {}
M.picker = {}
M.picker.state = nil

-- TODO: fuzzy search
-- TODO: scoring and sorting
-- TODO: preview

local function is_git_repo()
  if vim.fn.executable("git") ~= 1 then
    return false
  end

  vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
  return vim.v.shell_error == 0
end

function M.picker.filter(query)
  local state = M.picker.state
  if not state or not state.items or not state.qf_winid or state.qf_winid == 0 then
    return
  end

  local filtered = {}
  local lower_query = query:lower()
  for _, item in ipairs(state.items) do
    if item.filename:lower():find(lower_query, 1, true) then
      filtered[#filtered + 1] = item
    end
  end

  vim.fn.setqflist({}, "r")

  state.qf_cursor = 1

  local render_chunk = M.render.make_chunk_render(filtered, {
    title = query == "" and "Files" or "Files: " .. query,
  })
  render_chunk()
end

local function setup_prompt_keymaps(buf, prompt_win, qfwin, state)
  vim.keymap.set("i", "<c-w>", "<c-s-w>", { buf = buf })
  vim.keymap.set("i", "<c-c>", function()
    if prompt_win and vim.api.nvim_win_is_valid(prompt_win) then
      vim.api.nvim_win_close(prompt_win, true)
    end
    vim.cmd("cclose")
  end, { buf = buf, silent = true })

  vim.keymap.set("i", "<c-n>", function()
    local current = vim.fn.win_getid()
    vim.api.nvim_set_current_win(qfwin)
    vim.cmd("normal! j")
    vim.api.nvim_set_current_win(current)
  end, { buffer = buf, silent = true })
  vim.keymap.set("i", "<c-p>", function()
    local current = vim.fn.win_getid()
    vim.api.nvim_set_current_win(qfwin)
    vim.cmd("normal! k")
    vim.api.nvim_set_current_win(current)
  end, { buffer = buf, silent = true })
  vim.keymap.set("i", "<cr>", function()
    local current = vim.fn.win_getid()
    vim.api.nvim_set_current_win(qfwin)
    local qfitem = vim.fn.getqflist({ items = 0 }).items[vim.fn.line(".")]
    if qfitem then
      if prompt_win and vim.api.nvim_win_is_valid(prompt_win) then
        vim.api.nvim_win_close(prompt_win, true)
      end
      vim.cmd("cclose")
      local fname = vim.fn.bufname(qfitem.bufnr)
      if fname == "" then
        fname = qfitem.filename
      end
      vim.cmd("edit " .. fname)
      vim.cmd(tostring(qfitem.lnum))
    end
  end, { buffer = buf, silent = true })
  vim.keymap.set("i", "<esc>", function()
    if prompt_win and vim.api.nvim_win_is_valid(prompt_win) then
      vim.api.nvim_win_close(prompt_win, true)
    end
    vim.api.nvim_set_current_win(qfwin)
  end, { buffer = buf, silent = true })

  local pending = false
  vim.api.nvim_create_autocmd("TextChangedI", {
    buffer = buf,
    callback = function()
      if pending then
        return
      end
      pending = true
      vim.defer_fn(function()
        pending = false
        local prompt_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or ""
        local query = prompt_line:sub(3)
        M.picker.filter(query)
      end, 150)
    end,
  })
end

function M.picker.open_prompt(items)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("buftype", "prompt", { buf = buf })
  vim.fn.prompt_setprompt(buf, "> ")
  local qfwin = vim.fn.getqflist({ winid = 0 }).winid
  local prompt_win = vim.api.nvim_open_win(buf, true, {
    height = 1,
    style = "minimal",
    relative = "win",
    border = "none",
    win = qfwin,
    row = -1,
    col = 0,
    width = vim.o.columns,
  })
  vim.cmd("startinsert!")

  local state = {
    items = items,
    buf = buf,
    qf_winid = qfwin,
    prompt_win = prompt_win,
  }
  M.picker.state = state

  local qf_buf = vim.api.nvim_win_get_buf(qfwin)
  vim.keymap.set("n", "/", function()
    local st = M.picker.state
    if not st then
      return
    end
    if st.prompt_win and vim.api.nvim_win_is_valid(st.prompt_win) then
      vim.api.nvim_set_current_win(st.prompt_win)
    else
      local b = st.buf
      local qw = st.qf_winid
      local pw = vim.api.nvim_open_win(b, true, {
        height = 1,
        style = "minimal",
        relative = "win",
        border = "none",
        win = qw,
        row = -1,
        col = 0,
        width = vim.o.columns,
      })
      st.prompt_win = pw
      setup_prompt_keymaps(b, pw, qw, st)
    end
    local col = vim.fn.strlen(line)
    vim.api.nvim_win_set_cursor(0, { 1, col })
    vim.cmd("startinsert!")
  end, { buffer = qf_buf, noremap = true, silent = true })

  setup_prompt_keymaps(buf, prompt_win, qfwin, state)
  M.picker.filter("")
end

---@param path string
---@param items string[]
---@param t string? @default "file"
function M.fs.scan(path, items, t)
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

function M.source.fd_files(opts)
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

-- TODO: use unified source without dependency checking
function M.builtins.find_files()
  local title_loading = "Loading..."
  local title = "Files"
  local items = {}

  if vim.fn.executable("fd") then
    items = M.source.fd_files()
  elseif is_git_repo() then
    items = M.source.git_files()
  else
    items = M.source.fs_files()
  end

  vim.cmd("copen")
  vim.fn.setqflist({}, " ", { title = title_loading })
  M.picker.open_prompt(items)
end

function M.builtins.find_dirs()
  local title_loading = "Loading..."
  local title = "Directories"
  local items = {}

  if vim.fn.executable("fd") then
    items = M.source.fd_files({ fs_type = "directory" })
  elseif is_git_repo() then
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
  M.picker.open_prompt(items)
end

function M.builtins.grep(opts)
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

function M.builtins.buffer_grep(opts)
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

function M.builtins.oldfiles(opts)
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

function M.qftf(info)
  local items
  if info.quickfix == 1 then
    items = vim.fn.getqflist({ items = 1 }).items
  else
    items = vim.fn.getloclist(info.winid, { items = 1 }).items
  end

  local max_fname, max_lnum, max_col = 0, 0, 0

  for _, qf in ipairs(items) do
    local fname = vim.fn.bufname(qf.bufnr)
    if fname == "" then
      fname = qf.filename or ""
    end

    local fwidth = vim.fn.strwidth(fname)
    if fwidth > max_fname then
      max_fname = fwidth
    end

    local lnum_w = vim.fn.strwidth(tostring(qf.lnum or ""))
    if lnum_w > max_lnum then
      max_lnum = lnum_w
    end

    local col_w = vim.fn.strwidth(tostring(qf.col or ""))
    if col_w > max_col then
      max_col = col_w
    end
  end

  local lines = {}

  for _, qf in ipairs(items) do
    local fname = vim.fn.bufname(qf.bufnr)
    if fname == "" then
      fname = qf.filename or ""
    end

    if not qf.text or qf.text == "" then
      table.insert(lines, fname)
    else
      local padded_fname = fname .. string.rep(" ", max_fname - vim.fn.strwidth(fname))

      local lnum = tostring(qf.lnum or "")
      local padded_lnum = string.rep(" ", max_lnum - vim.fn.strwidth(lnum)) .. lnum

      local col = tostring(qf.col or "")
      local padded_col = col .. string.rep(" ", max_col - vim.fn.strwidth(col))

      table.insert(lines, string.format("%s |%s:%s| %s", padded_fname, padded_lnum, padded_col, qf.text))
    end
  end

  return lines
end

function M.register_quickfixtextfunc()
  vim.o.quickfixtextfunc = "v:lua.require'fqf'.qftf"
end

function M.ui_select(items, opts, on_choice)
  opts = opts or {}

  local qf_items = {}
  local prompt = opts.prompt or "Select"
  local format_item = opts.format_item or tostring
  for _, item in ipairs(items) do
    qf_items[#qf_items + 1] = {
      text = format_item(item),
      user_data = item,
    }
  end

  vim.fn.setqflist({}, " ", {
    title = prompt,
    items = qf_items,
  })

  vim.cmd("copen")

  local win = vim.fn.getqflist({ winid = 0 }).winid
  if win == 0 then
    win = vim.fn.win_getid()
  end

  local buf = vim.api.nvim_win_get_buf(win)

  vim.keymap.set("n", "<CR>", function()
    local idx = vim.fn.line(".")
    local list = vim.fn.getqflist()

    vim.cmd("cclose")

    local item = list[idx] and list[idx].user_data
    on_choice(item)
  end, { buffer = buf, silent = true })
end

function M.setup(opts)
  opts = opts or {}
  local register_ui_select = opts.register_ui_select ~= false
  local register_quickfixtextfunc = opts.register_quickfixtextfunc ~= false

  if register_ui_select then
    vim.ui.select = M.ui_select
  end

  if register_quickfixtextfunc then
    M.register_quickfixtextfunc()
  end
end

return M
