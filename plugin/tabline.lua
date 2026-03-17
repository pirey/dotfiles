local function shorten_dir(dir)
  local home = vim.env.HOME
  return dir == "" and "" or vim.startswith(dir, home) and "~" .. dir:sub(#home + 1) or dir
end

local function render()
  local tabs = {}
  local by_name = {}
  for i, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    local bufnr = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabpage))
    local buf_name = vim.api.nvim_buf_get_name(bufnr)
    local name = buf_name == "" and "[No Name]" or vim.fn.fnamemodify(buf_name, ":t")
    local dir = buf_name == "" and "" or shorten_dir(vim.fn.fnamemodify(buf_name, ":h"))
    tabs[i] = { name = name, dir = dir, modified = vim.bo[bufnr].modified, page = i }
  end

  for _, tab in ipairs(tabs) do
    by_name[tab.name] = (by_name[tab.name] or 0) + 1
  end

  for _, tab in ipairs(tabs) do
    if by_name[tab.name] > 1 then
      tab.name = tab.dir .. "/" .. tab.name
    end
    tab.name = " " .. tab.name .. (tab.modified and " ●" or "") .. " "
  end

  local cur = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())
  local cols = vim.go.columns
  local line, shown = "", 0

  for _, tab in ipairs(tabs) do
    local w = vim.fn.strdisplaywidth(tab.name)
    if shown + w <= cols then
      line = line .. "%#" .. (tab.page == cur and "TabLineSel" or "TabLine") .. "#%" .. tab.page .. "T" .. tab.name .. "%T"
      shown = shown + w
    else
      break
    end
  end

  return line .. (shown <= cols - 4 and "%#TabLineFill#" or "%#TabLine# … ")
end

vim.go.tabline = render()

vim.api.nvim_create_autocmd({ "TabEnter", "TabLeave", "BufEnter", "TabNew", "TabClosed" }, {
  callback = function()
    vim.go.tabline = render()
  end
})
