local H = require("fqf.helpers")

-- TODO: preview
-- TODO: custom action
-- TODO: attach to quickfix :copen

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

local View = {}
View.__index = View

function View:new(items, opts)
  return setmetatable({
    list_nr = nil,
    promptbuf = nil,
    promptwin = nil,
    promptopen = false,
    prompt = opts.prompt or "> ",
    qfopen = false,
    qfbuf = nil,
    qfwin = nil,
    query = "",
    items = items,
    filtered = items,
    opts = opts or {},
  }, View)
end

function View:open(opts)
  if self.qfopen and self.promptopen then
    return
  end

  self:open_qf(vim.tbl_deep_extend("force", self.opts, opts or {}))
  self:open_prompt()
  self:set_qf_keymaps()
  self:set_prompt_keymaps()
end

function View:open_qf(opts)
  render_items(self.filtered, opts)
  vim.cmd("copen")
  self.qfopen = true
  self.qfwin = vim.fn.getqflist({ winid = 0 }).winid
  self.qfbuf = vim.api.nvim_win_get_buf(self.qfwin)
end

function View:open_prompt()
  if self.promptopen then
    return
  end
  self.promptopen = true
  self.promptbuf = vim.api.nvim_create_buf(false, true)
  self.promptwin = vim.api.nvim_open_win(self.promptbuf, true, {
    height = 1,
    style = "minimal",
    relative = "win",
    border = "none",
    win = self.qfwin,
    row = -1,
    col = 0,
    width = vim.o.columns, -- TODO: set width for loclist
  })
  vim.api.nvim_set_option_value("buftype", "prompt", { buf = self.promptbuf })
  vim.fn.prompt_setprompt(self.promptbuf, self.prompt)
  vim.cmd("startinsert!")
  if self.query then
    -- vim.api.nvim_input(self.query)
    vim.api.nvim_feedkeys(self.query, "i", false)
  end
end

function View:set_prompt_keymaps()
  vim.keymap.set("i", "<c-w>", "<c-s-w>", { buf = self.promptbuf })
  vim.keymap.set("i", "<c-c>", function()
    self:close()
  end, { buf = self.promptbuf, silent = true })
  vim.keymap.set("i", "<c-n>", function()
    if not self.qfwin or not vim.api.nvim_win_is_valid(self.qfwin) then
      return
    end
    vim.api.nvim_set_current_win(self.qfwin)
    vim.cmd("normal! j")
    vim.api.nvim_set_current_win(self.promptwin)
  end, { buffer = self.promptbuf, silent = true })
  vim.keymap.set("i", "<c-p>", function()
    if not self.qfwin or not vim.api.nvim_win_is_valid(self.qfwin) then
      return
    end
    vim.api.nvim_set_current_win(self.qfwin)
    vim.cmd("normal! k")
    vim.api.nvim_set_current_win(self.promptwin)
  end, { buffer = self.promptbuf, silent = true })
  vim.keymap.set("i", "<cr>", function()
    if not self.qfwin or not vim.api.nvim_win_is_valid(self.qfwin) then
      return
    end
    vim.api.nvim_set_current_win(self.qfwin)
    local qfitem = vim.fn.getqflist({ items = 0 }).items[vim.fn.line(".")]
    if qfitem then
      self:close()
      local fname = vim.fn.bufname(qfitem.bufnr)
      if fname == "" then
        return
      end
      vim.cmd("edit " .. fname)
      vim.cmd(tostring(qfitem.lnum))
    end
  end, { buffer = self.promptbuf, silent = true })
  vim.keymap.set("i", "<esc>", function()
    if not self.qfwin or not vim.api.nvim_win_is_valid(self.qfwin) then
      return
    end
    vim.api.nvim_set_current_win(self.qfwin)
    self:close_prompt()
  end, { buffer = self.promptbuf, silent = true })

  vim.api.nvim_buf_attach(self.promptbuf, false, {
    on_lines = H.debounce(function()
      local prompt_line = vim.api.nvim_buf_get_lines(self.promptbuf, 0, 1, false)[1] or ""
      self.query = prompt_line:sub(#self.prompt + 1)
      self:filter()
    end, 50),
  })
end

function View:set_qf_keymaps()
  vim.keymap.set("n", "/", function()
    if not self.qfopen then
      return
    end
    self:open_prompt()
    self:set_prompt_keymaps()
  end, { buffer = self.qfbuf, noremap = true, silent = true })
end

function View:close()
  if not self.qfwin or not vim.api.nvim_win_is_valid(self.qfwin) then
    return
  end
  self.qfopen = false
  vim.api.nvim_win_close(self.qfwin, true)

  self:close_prompt()
end

function View:close_prompt()
  self.promptopen = false
  vim.api.nvim_win_close(self.promptwin, true)
end

function View:filter()
  if not self.qfopen or not self.items or not self.qfwin or self.qfwin == 0 then
    return
  end

  self.filtered = {}
  if #self.query > 0 then
    if type(self.opts.onchange) == "function" then
      self.filtered = self.opts.onchange(self.query)
    else
      self.filtered = vim.fn.matchfuzzy(self.items, self.query, {
        key = "filename",
      })
    end
  else
    self.filtered = self.items
  end

  local title = self.opts.title or "Items"
  render_items(self.filtered, {
    title = self.query == "" and title or title .. " : " .. self.query,
  })
end

return View
