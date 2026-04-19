local H = require("fqf.helpers")
local config = require("fqf.config")

-- TODO: preview
-- TODO: attach to quickfix :copen
-- TODO: prompt position

local View = {}
View.__index = View

View.default_opts = {
  use_lwin = false,
  filterby = "filename",
  prompt = nil,
}

function View:new(items, opts)
  opts = vim.tbl_deep_extend("force", View.default_opts, opts or {})
  local prompt = opts.prompt ~= nil and opts.prompt or config.opts.prompt.prefix
  return setmetatable({
    list_idx = 1,
    list_nr = nil,
    promptbuf = nil,
    promptwin = nil,
    promptopen = false,
    prompt = prompt,
    listopen = false,
    qfbuf = nil,
    qfwin = nil,
    lwin = nil,
    lbuf = nil,
    lsourcewin = nil,
    prevwin = nil,
    query = "",
    items = items,
    filtered = items,
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
    ["focus_prompt"] = function()
      if not self.promptwin or not vim.api.nvim_win_is_valid(self.promptwin) then
        return
      end
      vim.api.nvim_set_current_win(self.promptwin)
    end,
    ["close"] = function()
      self:close()
    end,
    ["focus_list"] = function()
      local listwin = self:get_list_win()
      if not listwin then
        return
      end
      vim.api.nvim_set_current_win(listwin)
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
  return "<Nop>"
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
  self.prompt = ""
  self.listopen = false
  self.qfbuf = nil
  self.qfwin = nil
  self.lwin = nil
  self.lbuf = nil
  self.lsourcewin = nil
  self.prevwin = nil
  self.query = ""
  self.render_gen = 0
  self.items = {}
  self.filtered = {}
  self.opts = {}
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

  self.render_gen = self.render_gen + 1

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
  local CHUNK_SIZE = 100
  local RENDER_DELAY = 10
  local idx = 1

  if self.opts.use_lwin then
    vim.fn.setloclist(self.lsourcewin, {}, " ", { title = title })
  else
    vim.fn.setqflist({}, " ", { title = title })
  end

  local timer = vim.uv.new_timer()
  self.render_timer = timer

  if not timer then return end

  local function render_chunk_rec()
    if gen ~= self.render_gen then
      return
    end

    local chunk = vim.list_slice(items, idx, math.min(idx + CHUNK_SIZE - 1, #items))

    if self.opts.use_lwin then
      vim.fn.setloclist(self.lsourcewin, {}, "a", { items = chunk })
    else
      vim.fn.setqflist({}, "a", { items = chunk })
    end

    idx = idx + CHUNK_SIZE
    if idx <= #items then
      timer:start(RENDER_DELAY, 0, function()
        render_chunk_rec()
      end)
    end
  end

  render_chunk_rec()
end

return View
