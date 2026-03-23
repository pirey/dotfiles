local ft_names = {
  fugitive = "Fugitive",
  fzf = "FZF",
  git = "Git",
  terminal = "Term",
}

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
      local ft = vim.bo[bufnr].filetype
      local buftype = vim.bo[bufnr].buftype
      local name_from_buf = buf_name ~= "" and (vim.fn.fnamemodify(buf_name, ":t") or "") or ""
      if ft_names[ft] then
        name = ft_names[ft]
      elseif ft_names[buftype] then
        name = ft_names[buftype]
      elseif name_from_buf ~= "" then
        name = name_from_buf
      else
        name = ft ~= "" and ft or "[No Name]"
      end
      local wins = #vim.api.nvim_tabpage_list_wins(tabpage)
      local win_indicator = wins > 1 and " " .. wins .. " " or ""
      if ft_names[ft] or ft_names[buftype] then
        win_indicator = ""
      end
      name = " " .. name .. (vim.bo[bufnr].modified and " ●" or "") .. win_indicator .. " "
    end
    line = line .. "%#" .. (i == cur and "TabLineSel" or "TabLine") .. "#%" .. i .. "T" .. name .. "%T"
  end

  return line .. "%#TabLine#"
end

vim.go.tabline = render()

vim.api.nvim_create_autocmd({ "TabEnter", "TabLeave", "BufEnter", "TabNew", "TabClosed", "WinEnter", "WinClosed", "TermOpen", "TermClose" }, {
  callback = function()
    vim.defer_fn(function() vim.go.tabline = render() end, 0)
  end
})
