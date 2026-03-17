local function render()
  local line = ""
  local cur = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())

  for i, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    local bufnr = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabpage))
    local name
    if bufnr == 0 or not vim.api.nvim_buf_is_valid(bufnr) then
      name = " [invalid] "
    else
      local buf_name = vim.api.nvim_buf_get_name(bufnr)
      name = buf_name == "" and "[No Name]" or (vim.fn.fnamemodify(buf_name, ":t") or "[No Name]")
      local wins = #vim.api.nvim_tabpage_list_wins(tabpage)
      local win_indicator = wins > 1 and " " .. wins .. " " or ""
      name = " " .. name .. (vim.bo[bufnr].modified and " ●" or "") .. win_indicator .. " "
    end
    line = line .. "%#" .. (i == cur and "TabLineSel" or "TabLine") .. "#%" .. i .. "T" .. name .. "%T"
  end

  return line .. "%#TabLine#"
end

vim.go.tabline = render()

vim.api.nvim_create_autocmd({ "TabEnter", "TabLeave", "BufEnter", "TabNew", "TabClosed" }, {
  callback = function() vim.go.tabline = render() end
})
