local function format_table()
  local cursor_row = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local function is_table_line(line) return line:match("^%s*|") end

  local start_row = cursor_row
  while start_row > 1 and is_table_line(lines[start_row]) do start_row = start_row - 1 end
  if not is_table_line(lines[start_row]) then start_row = start_row + 1 end

  local end_row = cursor_row
  while end_row < #lines and is_table_line(lines[end_row]) do end_row = end_row + 1 end
  if not is_table_line(lines[end_row]) then end_row = end_row - 1 end

  if start_row > end_row then
    vim.notify("Not inside a markdown table", vim.log.levels.WARN)
    return
  end

  local indent = lines[start_row]:match("^%s*") or ""
  local table_lines = {}
  for i = start_row, end_row do table_lines[#table_lines + 1] = vim.trim(lines[i]) end

  local rows, has_leading, has_trailing = {}, nil, nil
  for idx, line in ipairs(table_lines) do
    local cells = vim.split(line, "%|")
    if idx == 1 then
      has_leading = cells[1]:match("^%s*$") and true or false
      has_trailing = cells[#cells]:match("^%s*$") and true or false
    end
    if has_leading then table.remove(cells, 1) end
    if has_trailing then table.remove(cells) end
    for i, c in ipairs(cells) do cells[i] = vim.trim(c) end
    rows[#rows + 1] = cells
  end

  if #rows == 0 then return end

  local sep_idx
  for i, row_cells in ipairs(rows) do
    local ok = true
    for _, c in ipairs(row_cells) do if not c:match("^:?-+:?$") then ok = false; break end end
    if ok and #row_cells > 0 then sep_idx = i; break end
  end

  local num_cols = 0
  for _, r in ipairs(rows) do num_cols = math.max(num_cols, #r) end

  local widths = {}
  for _ = 1, num_cols do widths[#widths + 1] = 3 end
  for i, r in ipairs(rows) do
    if i ~= sep_idx then
      for j, c in ipairs(r) do widths[j] = math.max(widths[j], vim.fn.strdisplaywidth(c)) end
    end
  end

  local result_lines = {}
  for i, r in ipairs(rows) do
    local parts = {}
    for j = 1, num_cols do
      local c, w = r[j] or "", widths[j]
      if i == sep_idx and c:match("^:?-+:?$") then
        local l, _, ri = c:match("^(:?)(-+)(:?)$")
        if l == ":" and ri == ":" then c = ":" .. string.rep("-", math.max(3, w - 2)) .. ":"
        elseif l == ":" then c = ":" .. string.rep("-", math.max(3, w - 1))
        elseif ri == ":" then c = string.rep("-", math.max(3, w - 1)) .. ":"
        else c = string.rep("-", math.max(3, w)) end
      elseif i ~= sep_idx then
        c = c .. string.rep(" ", math.max(0, w - vim.fn.strdisplaywidth(c)))
      end
      parts[j] = c
    end
    local sep = " | "
    local line
    if has_leading and has_trailing then line = "| " .. table.concat(parts, sep) .. " |"
    elseif has_leading then line = "| " .. table.concat(parts, sep)
    elseif has_trailing then line = table.concat(parts, sep) .. " |"
    else line = table.concat(parts, sep) end
    result_lines[#result_lines + 1] = indent .. line
  end

  vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, result_lines)
end

function _G.format_table_expr()
  if vim.fn.getline("."):match("^%s*|") then
    format_table()
    return 0
  end
  return 1
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.bo.formatexpr = [[v:lua.format_table_expr()]]
  end,
})
