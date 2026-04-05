local ft_names = {
  fugitive = "Fugitive",
  fzf = "FZF",
  terminal = "Term",
}

local special_fts = vim.g.tabline_special_filetypes or {
  fugitive = "Fugitive",
  dbui = "DBUI",
}

local function git_log_hash_range(bufnr)
  local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
  local last_line = vim.api.nvim_buf_get_lines(bufnr, -2, -1, false)[1] or ""
  local first_hash = first_line:match("^%x+")
  local last_hash = last_line:match("^%x+")

  if first_hash == nil then
    return false, ""
  else
    return true, first_hash .. "..." .. last_hash
  end
end

local function get_tab_title(tabpage)
  local wins = vim.api.nvim_tabpage_list_wins(tabpage)
  for _, win in ipairs(wins) do
    local bufnr = vim.api.nvim_win_get_buf(win)
    if bufnr ~= 0 and vim.api.nvim_buf_is_valid(bufnr) then
      local ft = vim.bo[bufnr].filetype
      local custom_name = special_fts[ft]
      if custom_name then
        return true, custom_name
      end
    end
  end
  return false, nil
end

local function render()
  local line = ""
  local cur = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())

  for i, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    local bufnr = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabpage))
    local name
    local is_special, special_name = get_tab_title(tabpage)
    if bufnr == 0 or not vim.api.nvim_buf_is_valid(bufnr) then
      name = " [invalid] "
    elseif is_special then
      name = " " .. special_name .. " "
    else
      local buf_name = vim.api.nvim_buf_get_name(bufnr)
      local ft = vim.bo[bufnr].filetype
      local buftype = vim.bo[bufnr].buftype
      local name_from_buf = buf_name ~= "" and (vim.fn.fnamemodify(buf_name, ":t") or "") or ""
      if ft_names[ft] then
        name = ft_names[ft]
      elseif ft_names[buftype] then
        name = ft_names[buftype]
      elseif ft == "git" then
        local is_log, hash_range = git_log_hash_range(bufnr)
        if is_log then
          name = "Git Log: " .. hash_range
        else
          name = "Git: " .. name_from_buf:sub(1, 7)
        end
      elseif name_from_buf ~= "" then
        name = name_from_buf
      else
        name = ft ~= "" and ft or "[No Name]"
      end
      local wins = vim.api.nvim_tabpage_list_wins(tabpage)
      local has_diff = vim.iter(wins):any(function(win)
        return vim.wo[win].diff
      end)
      name = " " .. (has_diff and "Diff: " or "") .. name .. " "
    end
    line = line .. "%#" .. (i == cur and "TabLineSel" or "TabLine") .. "#%" .. i .. "T" .. name .. "%T"
  end

  return line .. "%#TabLine#"
end

vim.go.tabline = render()

vim.api.nvim_create_autocmd(
  { "TabEnter", "TabLeave", "BufEnter", "TabNew", "TabClosed", "WinEnter", "WinClosed", "TermOpen", "TermClose" },
  {
    callback = function()
      vim.defer_fn(function()
        vim.go.tabline = render()
      end, 0)
    end,
  }
)
