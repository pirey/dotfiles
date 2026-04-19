local H = require("fqf.helpers")
local config = require("fqf.config")

-- TODO: preview
-- TODO: attach to quickfix :copen
-- TODO: prompt position

local View = {}
View.__index = View

View.default_opts = {
  use_lwin = false,
  filter_by = "filename",
  filter_debounce = 50,
  chunk_size = 100,
  prompt = nil,
}

function View:new(items, opts)
  opts = vim.tbl_deep_extend("force", View.default_opts, opts or {}, {
    chunk_size = View.default_opts.chunk_size,
  })
  local prompt = opts.prompt ~= nil and opts.prompt or config.opts.prompt.prefix
  return setmetatable({
    list_idx = 1,
    list_nr = nil,
    promptbuf = nil,
    promptwin = nil,
    promptopen = false,
    prompt = prompt,
    listopen = false,
    listfocus = false,
    qfbuf = nil,
    qfwin = nil,
    lwin = nil,
    lbuf = nil,
    lsourcewin = nil,
    prevwin = nil,
    query = "",
    items = items,
    filtered = items,
    render_idx = 1,
    render_gen = 0,
    render_timer = nil,
    augroup = vim.api.nvim_create_augroup("FqfView", { clear = true }),
    opts = opts,
  }, View)
end

function View:open()
  if self.listopen and self.promptopen then
    return
  end

  self.prevwin = vim.api.nvim_get_current_win()
  self:open_list()
  self:open_prompt()
  self:set_list_keymaps()
  self:set_prompt_keymaps()
end

function View:open_list()
  self:render_items()
  self.listopen = true
  local shownumber = false
  local showsigncolumn = "yes"
  if self.opts.use_lwin then
    self.lsourcewin = vim.api.nvim_get_current_win()
    vim.cmd("lopen")
    self.lwin = vim.fn.getloclist(self.lsourcewin, { winid = 0 }).winid
    self.lbuf = vim.api.nvim_win_get_buf(self.lwin)
    vim.wo[self.lwin].number = shownumber
    vim.wo[self.lwin].signcolumn = showsigncolumn
  else
    vim.cmd("copen")
    self.qfwin = vim.fn.getqflist({ winid = 0 }).winid
    self.qfbuf = vim.api.nvim_win_get_buf(self.qfwin)
    vim.wo[self.qfwin].number = shownumber
    vim.wo[self.qfwin].signcolumn = showsigncolumn
  end

  local listbuf = self:get_list_buf()
  vim.api.nvim_create_autocmd("WinClosed", {
    group = self.augroup,
    buffer = listbuf,
    callback = function()
      self:close_prompt()
    end,
  })
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
    win = listwin,
    row = -1,
    col = 0,
    width = listwin_width,
  })
  vim.api.nvim_set_option_value("buftype", "prompt", { buf = self.promptbuf })
  vim.fn.prompt_setprompt(self.promptbuf, self.prompt)
  vim.cmd("startinsert!")
  if self.query then
    vim.api.nvim_feedkeys(self.query, "i", false)
  end
end

function View:action_handler(action)
  local actions = {
    ["cancel"] = function()
      self.render_gen = self.render_gen + 1
      if self.render_timer then
        self.render_timer:close()
        self.render_timer = nil
      end
    end,
    ["focus_prompt"] = function()
      if not self.promptwin or not vim.api.nvim_win_is_valid(self.promptwin) then
        return
      end
      vim.api.nvim_set_current_win(self.promptwin)
      self.listfocus = false
      self:render_items()
    end,
    ["focus_list"] = function()
      local listwin = self:get_list_win()
      if not listwin then
        return
      end
      vim.api.nvim_set_current_win(listwin)
      self.listfocus = true
      self:render_items()
    end,
    ["close"] = function()
      self:close()
    end,
    ["open"] = function()
      self:action_open("edit")
    end,
    ["open_vsplit"] = function()
      self:action_open("vsplit")
    end,
    ["open_split"] = function()
      self:action_open("split")
    end,
    ["open_tab"] = function()
      self:action_open("tabnew")
    end,
    ["up"] = function()
      local listwin = self:get_list_win()
      if not listwin then
        return
      end
      local idx = self:get_list_idx()
      self:set_list_idx(idx - 1)
    end,
    ["down"] = function()
      local listwin = self:get_list_win()
      if not listwin then
        return
      end
      local idx = self:get_list_idx()
      self:set_list_idx(idx + 1)
    end,
  }
  local handler = actions[action]
  if handler ~= nil then
    return handler
  end
  return function() end
end

function View:set_prompt_keymaps()
  for action, keys in pairs(config.opts.prompt.keymaps) do
    for _, key in ipairs(keys) do
      if key then
        vim.keymap.set("i", key, self:action_handler(action), { buf = self.promptbuf })
      end
    end
  end
  vim.keymap.set("i", "<c-w>", "<c-s-w>", { buf = self.promptbuf })

  vim.api.nvim_buf_attach(self.promptbuf, false, {
    on_lines = H.debounce(function()
      if not self.promptbuf or not vim.api.nvim_buf_is_valid(self.promptbuf) then
        return
      end
      local prompt_line = vim.api.nvim_buf_get_lines(self.promptbuf, 0, 1, false)[1] or ""
      self.query = prompt_line:sub(#self.prompt + 1)
      vim.fn.setreg("/", self.query)
      self:filter()
      if self.list_idx ~= 1 then
        self:set_list_idx(1)
      end
    end, self.opts.filter_debounce),
  })
end

function View:set_list_keymaps()
  local buf = self:get_list_buf()
  if not buf then
    return
  end
  for action, keys in pairs(config.opts.list.keymaps) do
    for _, key in ipairs(keys) do
      if key then
        vim.keymap.set("n", key, self:action_handler(action), { buf = buf })
      end
    end
  end
end

function View:close()
  local listwin = self:get_list_win()
  if not self.listopen or not listwin then
    return
  end
  self.listopen = false
  vim.api.nvim_win_close(listwin, true)
  self:close_prompt()

  if self.prevwin and vim.api.nvim_win_is_valid(self.prevwin) then
    vim.api.nvim_set_current_win(self.prevwin)
  end

  self:cleanup()
end

function View:cleanup()
  if self.render_timer then
    self.render_timer:close()
    self.render_timer = nil
  end

  vim.api.nvim_del_augroup_by_id(self.augroup)
  vim.api.nvim_buf_delete(self.promptbuf, { force = true })
  if self.qfbuf then
    vim.api.nvim_buf_delete(self.qfbuf, { force = true })
  end
  if self.lbuf then
    vim.api.nvim_buf_delete(self.lbuf, { force = true })
  end

  self.list_idx = 1
  self.list_nr = nil
  self.promptbuf = nil
  self.promptwin = nil
  self.promptopen = false
  self.listopen = false
  self.qfbuf = nil
  self.qfwin = nil
  self.lwin = nil
  self.lbuf = nil
  self.lsourcewin = nil
  self.prevwin = nil
  self.query = ""
  self.render_idx = 1
  self.render_gen = 0
  self.items = {}
  self.filtered = {}
  self.opts = {}
end

function View:close_prompt()
  if not self.promptwin or not vim.api.nvim_win_is_valid(self.promptwin) then
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

  self.render_gen = self.render_gen + 1

  self.filtered = {}
  if #self.query <= 0 then
    self.filtered = self.items
    self.render_idx = 1
    self:render_items()
  end

  if type(self.opts.on_change) == "function" then
    self.opts.on_change(self.query, function(result)
      self.filtered = result
      self.render_idx = 1
      self:render_items()
    end)
    return
  end

  self.filtered = vim.fn.matchfuzzy(self.items, self.query, {
    key = self.opts.filter_by,
  })

  self.render_idx = 1
  self:render_items()
end

function View:get_list_idx()
  if self.opts.use_lwin then
    return vim.fn.getloclist(self.lsourcewin, { idx = 0 }).idx
  else
    return vim.fn.getqflist({ idx = 0 }).idx
  end
end

function View:set_list_idx(idx)
  self.list_idx = idx
  if self.opts.use_lwin then
    vim.fn.setloclist(self.lsourcewin, {}, "a", { idx = idx })
  else
    vim.fn.setqflist({}, "a", { idx = idx })
  end
end

function View:get_list_buf()
  local listbuf = nil
  if self.opts.use_lwin then
    listbuf = self.lbuf
  else
    listbuf = self.qfbuf
  end
  return listbuf
end

function View:get_list_win()
  local listwin = nil
  if self.opts.use_lwin then
    listwin = self.lwin
  else
    listwin = self.qfwin
  end
  if not listwin or not vim.api.nvim_win_is_valid(listwin) then
    return nil
  end
  return listwin
end

function View:get_list_item()
  local listwin = self:get_list_win()
  if not listwin then
    return
  end

  local line = vim.api.nvim_win_call(listwin, function()
    return vim.fn.line(".")
  end)

  local list_item = nil
  if self.opts.use_lwin then
    list_item = vim.fn.getloclist(self.lsourcewin, { items = 0 }).items[line]
  else
    list_item = vim.fn.getqflist({ items = 0 }).items[line]
  end
  return list_item
end

function View:action_open(split)
  split = split or "edit"
  local list_item = self:get_list_item()
  if list_item then
    if self.opts.onselect then
      self.opts.onselect(list_item)
      self:close()
      return
    end
    self:close()
    local fname = vim.fn.bufname(list_item.bufnr)
    if fname == "" then
      return
    end
    vim.cmd(split .. " " .. fname)
    vim.cmd(tostring(list_item.lnum))
  end
end

function View:render_items()
  if self.render_timer then
    self.render_timer:close()
    self.render_timer = nil
  end

  local items = self.filtered
  if not items then
    return
  end

  local gen = self.render_gen
  local title = self.opts.title
  local RENDER_DELAY = 100

  if self.render_idx == 1 then
    if self.opts.use_lwin then
      vim.fn.setloclist(self.lsourcewin, {}, " ", { title = title })
    else
      vim.fn.setqflist({}, " ", { title = title })
    end
  end

  local timer = vim.uv.new_timer()
  self.render_timer = timer

  if not timer then
    return
  end

  local function render_chunk_rec()
    if gen ~= self.render_gen then
      return
    end

    local chunk = {}
    local end_idx = math.min(self.render_idx + self.opts.chunk_size - 1, #items)
    for i = self.render_idx, end_idx do
      chunk[#chunk + 1] = items[i]
    end

    if self.opts.use_lwin then
      vim.fn.setloclist(self.lsourcewin, {}, "a", { items = chunk })
    else
      vim.fn.setqflist({}, "a", { items = chunk })
    end

    self.render_idx = self.render_idx + self.opts.chunk_size
    local max = self.listfocus and #items or math.min(self.opts.chunk_size, #items)
    if self.render_idx <= max then
      timer:start(
        RENDER_DELAY,
        0,
        vim.schedule_wrap(function()
          render_chunk_rec()
        end)
      )
    end
  end

  render_chunk_rec()
end

return View
