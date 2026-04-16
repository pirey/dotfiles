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
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  if #lines < 2 then
    return false, ""
  end

  local first = lines[1]
  local last = lines[#lines]

  local first_hash = first:match("^(%x+)%s")
  local last_hash  = last:match("^(%x+)%s")

  if not first_hash or not last_hash then
    return false, ""
  end

  return true, first_hash .. "..." .. last_hash
end

local function render()
  local parts = {}
  local tabs = vim.api.nvim_list_tabpages()
  local cur = vim.api.nvim_get_current_tabpage()

  for i, tabpage in ipairs(tabs) do
    local wins = vim.api.nvim_tabpage_list_wins(tabpage)
    local main_win = vim.api.nvim_tabpage_get_win(tabpage)
    local bufnr = vim.api.nvim_win_get_buf(main_win)

    local name = " [invalid] "

    if bufnr ~= 0 and vim.api.nvim_buf_is_valid(bufnr) then
      local ft = vim.bo[bufnr].filetype
      local buftype = vim.bo[bufnr].buftype

      -- special filetypes
      local special_name = nil
      for _, win in ipairs(wins) do
        local b = vim.api.nvim_win_get_buf(win)
        local s = special_fts[vim.bo[b].filetype]
        if s then
          special_name = s
          break
        end
      end

      if special_name then
        name = " " .. special_name .. " "
      else
        local buf_name = vim.api.nvim_buf_get_name(bufnr)
        local short = buf_name ~= "" and vim.fn.fnamemodify(buf_name, ":t") or ""

        if ft_names[ft] then
          name = ft_names[ft]
        elseif ft_names[buftype] then
          name = ft_names[buftype]
        elseif ft == "git" then
          local is_log, hash = git_log_hash_range(bufnr)
          if is_log then
            name = "Git Log: " .. hash
          elseif #short > 7 then
            name = "Git: " .. short:sub(1, 7)
          else
            name = "Git"
          end
        elseif short ~= "" then
          name = short
        else
          name = ft ~= "" and ft or "[No Name]"
        end

        local has_diff = false
        for _, win in ipairs(wins) do
          if vim.wo[win].diff then
            has_diff = true
            break
          end
        end

        name = " " .. (has_diff and "Diff: " or "") .. name .. " "
      end
    end

    local hl = (tabpage == cur) and "%#TabLineSel#" or "%#TabLine#"
    parts[#parts + 1] = hl .. "%" .. i .. "T" .. name .. "%T"
  end

  return table.concat(parts) .. "%#Normal#"
end

vim.go.tabline = render()

vim.api.nvim_create_autocmd(
  { "TabEnter", "TabNew", "TabClosed", "BufEnter" },
  {
    callback = function()
      vim.go.tabline = render()
    end,
  }
)
