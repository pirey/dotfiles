local function ui_select(items, opts, on_choice)
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

return ui_select
