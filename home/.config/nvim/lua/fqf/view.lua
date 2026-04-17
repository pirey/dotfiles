local H = require("fqf.helpers")

-- TODO: keymap
-- TODO: open split
-- TODO: preview
-- TODO: attach to quickfix :copen
-- TODO: prompt position
-- TODO: more opts

local View = {}
View.__index = View

function View:render_items()
  local items = self.filtered
  local title = self.opts.title
  local CHUNK_SIZE = 100
  local RENDER_DELAY = 10
  local idx = 1

  if self.opts.use_lwin then
    vim.fn.setloclist(self.lsourcewin, {}, " ", { title = title })
  else
    vim.fn.setqflist({}, " ", { title = title })
  end

  local function render_chunk_rec()
    local chunk = vim.list_slice(items, idx, math.min(idx + CHUNK_SIZE - 1, #items))

    if self.opts.use_lwin then
      vim.fn.setloclist(self.lsourcewin, {}, "a", { items = chunk })
    else
      vim.fn.setqflist({}, "a", { items = chunk })
    end

    idx = idx + CHUNK_SIZE
    if idx <= #items then
      vim.defer_fn(function()
        render_chunk_rec()
      end, RENDER_DELAY)
    end
  end

  render_chunk_rec()
end

function View:new(items, opts)
  opts = vim.tbl_deep_extend("force", {
    use_lwin = false,
    filterby = "filename",
  }, opts or {})
  return setmetatable({
    list_nr = nil,
    promptbuf = nil,
    promptwin = nil,
    promptopen = false,
    prompt = opts.prompt or "> ",
    listopen = false,
    qfbuf = nil,
    qfwin = nil,
    lwin = nil,
    lbuf = nil,
    lsourcewin = nil,
    query = "",
    items = items,
    filtered = items,
    opts = opts,
  }, View)
end

function View:open()
  if self.listopen and self.promptopen then
    return
  end

  self:open_list()
  self:open_prompt()
  self:set_list_keymaps()
  self:set_prompt_keymaps()
end

function View:open_list()
  self:render_items()
  self.listopen = true
  if self.opts.use_lwin then
    self.lsourcewin = vim.api.nvim_get_current_win()
    vim.cmd("lopen")
    self.lwin = vim.fn.getloclist(self.lsourcewin, { winid = 0 }).winid
    self.lbuf = vim.api.nvim_win_get_buf(self.lwin)
  else
    vim.cmd("copen")
    self.qfwin = vim.fn.getqflist({ winid = 0 }).winid
    self.qfbuf = vim.api.nvim_win_get_buf(self.qfwin)
  end
end

function View:open_prompt()
  local listwin = self:get_list_win()
  if not listwin or self.promptopen then
    return
  end
  local listwin_width = vim.api.nvim_win_get_width(listwin)
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
    width = listwin_width,
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
    local listwin = self:get_list_win()
    if not listwin then
      return
    end
    vim.api.nvim_set_current_win(listwin)
    vim.cmd("normal! j")
    vim.api.nvim_set_current_win(self.promptwin)
  end, { buffer = self.promptbuf, silent = true })
  vim.keymap.set("i", "<c-p>", function()
    local listwin = self:get_list_win()
    if not listwin then
      return
    end
    vim.api.nvim_set_current_win(listwin)
    vim.cmd("normal! k")
    vim.api.nvim_set_current_win(self.promptwin)
  end, { buffer = self.promptbuf, silent = true })
  vim.keymap.set("i", "<cr>", function()
    self:action_open("edit")
  end, { buffer = self.promptbuf, silent = true })
  vim.keymap.set("i", "<c-v>", function()
    self:action_open("vsplit")
  end, { buffer = self.promptbuf, silent = true })
  vim.keymap.set("i", "<c-s>", function()
    self:action_open("split")
  end, { buffer = self.promptbuf, silent = true })
  vim.keymap.set("i", "<c-t>", function()
    self:action_open("tabnew")
  end, { buffer = self.promptbuf, silent = true })
  vim.keymap.set("i", "<esc>", function()
    local listwin = self:get_list_win()
    if not listwin then
      return
    end
    vim.api.nvim_set_current_win(listwin)
    self:close_prompt()
  end, { buffer = self.promptbuf, silent = true })

  vim.api.nvim_buf_attach(self.promptbuf, false, {
    on_lines = H.debounce(function()
      local prompt_line = vim.api.nvim_buf_get_lines(self.promptbuf, 0, 1, false)[1] or ""
      self.query = prompt_line:sub(#self.prompt + 1)
      vim.fn.setreg("/", self.query)
      vim.cmd("set hlsearch")
      self:filter()
    end, 50),
  })
end

function View:set_list_keymaps()
  local buf = nil
  if self.opts.use_lwin and self.lbuf ~= nil then
    buf = self.lbuf
  else
    buf = self.qfbuf
  end
  vim.keymap.set("n", "/", function()
    if not self.listopen then
      return
    end
    self:open_prompt()
    self:set_prompt_keymaps() -- prevent redundant keymap set
  end, { buffer = buf, noremap = true, silent = true })
end

function View:close()
  -- TODO: jump to previous window?
  local listwin = self:get_list_win()
  if not self.listopen or not listwin then
    return
  end
  self.listopen = false
  vim.api.nvim_win_close(listwin, true)

  self:close_prompt()
end

function View:close_prompt()
  if not vim.api.nvim_win_is_valid(self.promptwin) then
    return
  end
  self.promptopen = false
  vim.api.nvim_win_close(self.promptwin, true)
end

function View:filter()
  local listwin = self:get_list_win()
  if not self.listopen or not self.items or not listwin then
    return
  end

  self.filtered = {}
  if #self.query > 0 then
    if type(self.opts.onchange) == "function" then
      self.filtered = self.opts.onchange(self.query)
    else
      self.filtered = vim.fn.matchfuzzy(self.items, self.query, {
        key = self.opts.filterby,
      })
    end
  else
    self.filtered = self.items
  end

  self:render_items()
end

function View:get_list_win()
  local listwin = nil
  if self.opts.use_lwin then
    listwin = self.lwin
  else
    listwin = self.qfwin
  end
  if not vim.api.nvim_win_is_valid(listwin) then
    return nil
  end
  return listwin
end

function View:get_list_item()
  local listwin = self:get_list_win()
  if not listwin then
    return
  end
  vim.api.nvim_set_current_win(listwin)
  local list_item = nil
  if self.opts.use_lwin then
    list_item = vim.fn.getloclist(self.lsourcewin, { items = 0 }).items[vim.fn.line(".")]
  else
    list_item = vim.fn.getqflist({ items = 0 }).items[vim.fn.line(".")]
  end
  return list_item
end

function View:action_open(split)
  split = split or "edit"
  local list_item = self:get_list_item()
  if list_item then
    self:close()
    local fname = vim.fn.bufname(list_item.bufnr)
    if fname == "" then
      return
    end
    -- TODO: open in split or tab
    vim.cmd(split .. " " .. fname)
    vim.cmd(tostring(list_item.lnum))
    vim.cmd("nohlsearch")
  end
end

return View
