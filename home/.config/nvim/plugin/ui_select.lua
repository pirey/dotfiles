vim.ui.select = function(items, opts, on_choice)
  vim.cmd.stopinsert()
  opts = opts or {}
  local prompt = opts.prompt or "Select"
  local format_item = opts.format_item or tostring

  if #items == 0 then
    on_choice(nil)
    return
  end

  local lines = { prompt }
  local max_width = #prompt
  for i, item in ipairs(items) do
    local line = string.format("%d. %s", i, format_item(item))
    lines[i + 1] = line
    max_width = math.max(max_width, #line)
  end

  local width = max_width < 80 and math.max(max_width + 4, 80) or max_width
  local height = math.min(#lines, 20)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "cursor",
    width = width,
    height = height,
    col = 0,
    row = 1,
    style = "minimal",
    border = vim.o.winborder,
    zindex = 200,
  })

  vim.wo[win].cursorline = true
  vim.wo[win].cursorlineopt = "both"
  vim.wo[win].number = false
  vim.wo[win].signcolumn = "no"

  local ns = vim.api.nvim_create_namespace("ui_select")
  vim.hl.range(buf, ns, "Title", { 0, 0 }, { 0, #prompt }, {})
  vim.api.nvim_win_set_cursor(win, { 2, 0 })

  local map_opts = { buffer = buf, silent = true, nowait = true }
  vim.keymap.set("n", "<CR>", function()
    local line = vim.fn.line(".")
    if line > 1 and line <= #items + 1 then
      pcall(vim.api.nvim_win_close, win, true)
      on_choice(items[line - 1])
    end
  end, map_opts)

  vim.keymap.set("n", "<Esc>", function()
    pcall(vim.api.nvim_win_close, win, true)
    on_choice(nil)
  end, map_opts)

  vim.keymap.set("n", "q", function()
    pcall(vim.api.nvim_win_close, win, true)
    on_choice(nil)
  end, map_opts)
end
