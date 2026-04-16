local function render_items(items, opts)
  opts = vim.tbl_extend("force", {
    loclist_win = 0,
  }, opts or {})
  local title = opts.title
  local loclist_win = opts.loclist_win
  local CHUNK_SIZE = 100
  local RENDER_DELAY = 10
  local idx = 1

  if loclist_win > 0 then
    vim.fn.setloclist(loclist_win, {}, " ", { title = title })
  else
    vim.fn.setqflist({}, " ", { title = title })
  end

  local function render_chunk_rec()
    local chunk = vim.list_slice(items, idx, math.min(idx + CHUNK_SIZE - 1, #items))

    if loclist_win > 0 then
      vim.fn.setloclist(loclist_win, {}, "a", { items = chunk })
    else
      vim.fn.setqflist({}, "a", { items = chunk })
    end

    idx = idx + CHUNK_SIZE
    if idx <= #items then
      vim.defer_fn(function()
        render_chunk_rec()
      end, RENDER_DELAY)
    else
      -- finish
      if loclist_win > 0 then
        vim.fn.setloclist(loclist_win, {}, "a", { title = title })
      else
        vim.fn.setqflist({}, "a", { title = title })
      end
    end
  end

  render_chunk_rec()
end

local Prompt = {}
Prompt.__index = Prompt

function Prompt:new(view, opts)
  opts = opts or {}
  return setmetatable({
    is_open = false,
    buf = nil,
    win = nil,
    qfwin = nil,
    view = view,
    prompt = opts.prompt or "> ",
    prompt_text = "",
  }, Prompt)
end

function Prompt:open()
  local view = self.view
  if not view or self.is_open then
    return self
  end
  self.is_open = true
  self.buf = vim.api.nvim_create_buf(false, true)
  self.qfwin = view.qfwin
  self.win = vim.api.nvim_open_win(self.buf, true, {
    height = 1,
    style = "minimal",
    relative = "win",
    border = "none",
    win = self.qfwin,
    row = -1,
    col = 0,
    width = vim.o.columns, -- TODO: set width for loclist
  })
  vim.api.nvim_set_option_value("buftype", "prompt", { buf = self.buf })
  vim.fn.prompt_setprompt(self.buf, self.prompt)
  vim.cmd("startinsert!")
  self:keymap_set()
  return self
end

function Prompt:keymap_set()
  vim.keymap.set("i", "<c-w>", "<c-s-w>", { buf = self.buf })
  vim.keymap.set("i", "<c-c>", function()
    -- if win and vim.api.nvim_win_is_valid(win) then
    --   vim.api.nvim_win_close(win, true)
    -- end
    self:close()
    self.view:close()
  end, { buf = self.buf, silent = true })
  vim.keymap.set("i", "<c-n>", function()
    vim.api.nvim_set_current_win(self.qfwin)
    vim.cmd("normal! j")
    vim.api.nvim_set_current_win(self.win)
  end, { buffer = self.buf, silent = true })
  vim.keymap.set("i", "<c-p>", function()
    vim.api.nvim_set_current_win(self.qfwin)
    vim.cmd("normal! k")
    vim.api.nvim_set_current_win(self.win)
  end, { buffer = self.buf, silent = true })
  vim.keymap.set("i", "<cr>", function()
    vim.api.nvim_set_current_win(self.qfwin)
    local qfitem = vim.fn.getqflist({ items = 0 }).items[vim.fn.line(".")]
    -- local qfitem = self.view.items[vim.fn.line(".")]
    if qfitem then
      -- if win and vim.api.nvim_win_is_valid(win) then
      --   vim.api.nvim_win_close(win, true)
      -- end
      self:close()
      self.view:close()
      local fname = vim.fn.bufname(qfitem.bufnr)
      if fname == "" then
        --   fname = qfitem.filename
        return
      end
      -- local fname = qfitem.filename
      vim.cmd("edit " .. fname)
      vim.cmd(tostring(qfitem.lnum))
    end
  end, { buffer = self.buf, silent = true })
  vim.keymap.set("i", "<esc>", function()
    -- if prompt_win and vim.api.nvim_win_is_valid(prompt_win) then
    --   vim.api.nvim_win_close(prompt_win, true)
    -- end
    self:close()
    vim.api.nvim_set_current_win(self.qfwin)
  end, { buffer = self.buf, silent = true })

  vim.api.nvim_buf_attach(self.buf, false, {
    on_lines = function()
      local prompt_line = vim.api.nvim_buf_get_lines(self.buf, 0, 1, false)[1] or ""
      local query = prompt_line:sub(#self.prompt + 1)
      self.prompt_text = prompt_line
      self.view:filter(query)
    end,
  })
end

function Prompt:close()
  self.is_open = false
  vim.api.nvim_win_close(self.win, true)
end

local View = {}
View.__index = View

function View:new(items, opts)
  return setmetatable({
    list_nr = nil,
    is_open = false,
    promptwin = 0,
    qfbuf = 0,
    qfwin = 0,
    -- qfcursor = 1,
    query = "",
    items = items,
    filtered = items,
    opts = opts or {},
  }, View)
end

function View:open(opts)
  if self.is_open then
    return
  end

  render_items(self.filtered, opts)
  vim.cmd("copen")
  self.is_open = true
  self.qfwin = vim.fn.getqflist({ winid = 0 }).winid
  self.qfbuf = vim.api.nvim_win_get_buf(self.qfwin)
  self.promptwin = Prompt:new(self, opts):open().win

  self:keymap_set(opts)
end

function View:keymap_set(opts)
  vim.keymap.set("n", "/", function()
    if not self.is_open then
      return
    end
    if self.promptwin > 0 and vim.api.nvim_win_is_valid(self.promptwin) then
      vim.api.nvim_set_current_win(self.promptwin)
    else
      -- local b = st.buf
      -- local qw = st.qf_winid
      local p = Prompt:new(self, opts):open()
      self.promptwin = p.win
    end
    -- local col = vim.fn.strlen(line)
    -- vim.api.nvim_win_set_cursor(0, { 1, col })
    -- vim.cmd("startinsert!")
  end, { buffer = self.qfbuf, noremap = true, silent = true })
end

function View:close()
  self.is_open = false
  vim.api.nvim_win_close(self.qfwin, true)
end

function View:debug()
  print(vim.inspect(self))
end

function View:filter(query)
  if not self.is_open or not self.items or not self.qfwin or self.qfwin == 0 then
    return
  end

  self.filtered = {}
  if #query > 0 then
    self.filtered = vim.fn.matchfuzzy(self.items, query, {
      key = "filename",
    })
  else
    self.filtered = self.items
  end

  render_items(self.filtered, {
    title = query == "" and "Files" or "Files: " .. query,
  })
end

return View
