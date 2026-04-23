local function grep()
  local prompt = "Search: "
  local ok, query = pcall(vim.fn.input, prompt)
  if not ok or query == "" then
    return
  end
  vim.defer_fn(function()
    vim.cmd(string.format("silent grep! '%s'", query))
    vim.fn.setqflist({}, "a", { title = prompt .. query })
    vim.fn.setreg("/", query)
    local result = vim.fn.getqflist({ items = 0 }).items
    if #result > 0 then
      vim.cmd("copen")
      pcall(function(args)
        vim.cmd(args)
      end, "normal! n")
      vim.notify("Showing " .. #result .. " result for " .. query)
    else
      vim.cmd("cclose")
      vim.notify("Not found: " .. query)
    end
  end, 0)
end

local function buffer_lines()
  local prompt = "Search: "
  local ok, query = pcall(vim.fn.input, prompt)
  if not ok or query == "" then
    return
  end

  local bufnr = 0
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local filename = vim.api.nvim_buf_get_name(bufnr)

  local matches = vim.fn.matchfuzzy(lines, query)

  local qf = {}
  for _, line in ipairs(matches) do
    local lnum = vim.fn.index(lines, line) + 1
    table.insert(qf, {
      filename = filename,
      bufnr = bufnr,
      lnum = lnum,
      col = 1,
      text = line,
    })
  end

  vim.fn.setloclist(0, {}, " ", { items = qf, title = prompt .. query })
  vim.cmd("lopen")
  vim.fn.setreg("/", query)
end

local function toggle_cwindow()
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
end

local function toggle_lwindow()
  local winid = vim.fn.getloclist(0, { winid = 0 }).winid
  if winid ~= 0 then
    local curwin = vim.fn.win_getid()
    if curwin == winid then
      vim.cmd("lclose")
    else
      vim.cmd("lopen")
    end
  else
    vim.cmd("lopen")
  end
end

local function oldfiles()
  local cwd = vim.uv.cwd() or ""
  local items = {}
  for _, path in ipairs(vim.v.oldfiles) do
    if path:find(cwd, 1, true) == 1 and vim.uv.fs_stat(path) then
      items[#items + 1] = {
        filename = vim.fn.fnamemodify(path, ":."),
        lnum = 1,
        col = 1,
      }
    end
  end
  vim.fn.setqflist({}, ' ', {
    items = items,
    title = "Oldfiles",
    quickfixtextfunc = function()
      local lines = {}
      for _, item in ipairs(items) do
        table.insert(lines, item.filename)
      end
      return lines
    end,
  })
  vim.cmd("copen")
end

-- ignore .git by default so we doesn't need to specify it when using --hidden
vim.o.grepprg = "rg --hidden --vimgrep --smart-case --fixed-strings --glob=!.git"

vim.keymap.set("n", "<leader>c", toggle_cwindow)
vim.keymap.set("n", "<leader>l", toggle_lwindow)
vim.keymap.set("n", "<leader>,", grep)
vim.keymap.set("n", "<leader>/", buffer_lines)
vim.keymap.set("n", "<leader>'", oldfiles)

local augroup = vim.api.nvim_create_augroup("InitQF", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "qf",
  callback = function()
    local win = vim.fn.win_getid()
    vim.wo[win].cursorline = true
    vim.wo[win].cursorlineopt = "both"
    vim.wo[win].signcolumn = "yes"
    vim.wo[win].number = false
  end,
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
    quickfixtextfunc = function(info)
      local qfitems
      if info.quickfix == 1 then
        qfitems = vim.fn.getqflist({ items = 1 }).items
      else
        qfitems = vim.fn.getloclist(info.winid, { items = 1 }).items
      end

      local lines = {}

      for _, qf in ipairs(qfitems) do
        table.insert(lines, qf.text)
      end

      return lines
    end,
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

  vim.api.nvim_create_autocmd("WinLeave", {
    buffer = buf,
    once = true,
    callback = function()
      vim.keymap.del("n", "<CR>", {
        buf = buf,
      })
    end,
  })
end
