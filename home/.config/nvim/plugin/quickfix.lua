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
  local prompt = "/"
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
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end

local function toggle_lwindow()
  local winid = vim.fn.getloclist(0, { winid = 0 }).winid
  if winid ~= 0 then
    vim.cmd("lclose")
  else
    local ok = pcall(function()
      vim.cmd("lopen")
    end)
    if not ok then
      vim.notify("No location list")
    end
  end
end

local function buffers()
  local items = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buflisted then
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name ~= "" then
        items[#items + 1] = {
          filename = vim.fn.fnamemodify(name, ":."),
          bufnr = bufnr,
          lnum = 1,
          col = 1,
        }
      end
    end
  end
  vim.fn.setqflist({}, " ", {
    items = items,
    title = "Buffers",
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
  vim.fn.setqflist({}, " ", {
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

local augroup = vim.api.nvim_create_augroup("InitQF", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "qf",
  callback = function()
    vim.cmd("setl cursorline cursorlineopt=both signcolumn=yes nonumber")

    vim.keymap.set("n", "<leader><CR>", "<CR><Cmd>cclose<CR><Cmd>lclose<CR>", { buf = 0, remap = true })
  end,
})

-- ignore .git by default so we doesn't need to specify it when using --hidden
vim.o.grepprg = "rg --hidden --vimgrep --smart-case --fixed-strings --glob=!.git"

vim.keymap.set("n", "<leader>c", toggle_cwindow)
vim.keymap.set("n", "<leader>l", toggle_lwindow)
vim.keymap.set("n", "<leader>,", grep)
vim.keymap.set("n", "<leader>/", buffer_lines)
vim.keymap.set("n", "<leader>'", oldfiles)
vim.keymap.set("n", "<leader>b", buffers)
vim.cmd("packadd cfilter")
