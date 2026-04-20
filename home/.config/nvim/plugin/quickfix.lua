-- ignore .git by default so we doesn't need to specify it when using --hidden
vim.o.grepprg = "rg --hidden --vimgrep --smart-case --glob=!.git"

vim.keymap.set("n", "<leader>c", function()
  local winid = vim.fn.getqflist({ winid = 0 }).winid
  if winid ~= 0 then
    local curwin = vim.fn.win_getid()
    if curwin == winid then
      vim.cmd("cclose")
    else
      vim.cmd("copen")
    end
  else
    vim.cmd("copen")
  end
end)
vim.keymap.set("n", "<leader>,", function()
  local prompt = "Search: "
  local ok, query = pcall(vim.fn.input, prompt)
  if not ok or query == "" then
    return
  end
  vim.defer_fn(function()
    vim.cmd(string.format("silent grep! '%s'", query))
    vim.fn.setqflist({}, "a", { title = prompt .. query })
    vim.fn.setreg("/", query)
    pcall(function(args)
      vim.cmd(args)
    end, "normal! n")
  end, 0)
end)

local augroup = vim.api.nvim_create_augroup("Init", { clear = true })

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = augroup,
  pattern = "grep",
  callback = function()
    vim.cmd("copen")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "qf",
  callback = function() end,
})

vim.ui.select = function(items, opts, on_choice)
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
