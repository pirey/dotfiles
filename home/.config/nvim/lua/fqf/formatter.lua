local M = {}

function M.formatter(info)
  local items
  if info.quickfix == 1 then
    items = vim.fn.getqflist({ items = 1 }).items
  else
    items = vim.fn.getloclist(info.winid, { items = 1 }).items
  end

  local max_fname, max_lnum, max_col = 0, 0, 0

  for _, qf in ipairs(items) do
    local fname = vim.fn.bufname(qf.bufnr)
    if fname == "" then
      fname = qf.filename or ""
    end

    local fwidth = vim.fn.strwidth(fname)
    if fwidth > max_fname then
      max_fname = fwidth
    end

    local lnum_w = vim.fn.strwidth(tostring(qf.lnum or ""))
    if lnum_w > max_lnum then
      max_lnum = lnum_w
    end

    local col_w = vim.fn.strwidth(tostring(qf.col or ""))
    if col_w > max_col then
      max_col = col_w
    end
  end

  local lines = {}

  for _, qf in ipairs(items) do
    local fname = vim.fn.bufname(qf.bufnr)
    if fname == "" then
      fname = qf.filename or ""
    end

    if not qf.text or qf.text == "" then
      table.insert(lines, fname)
    elseif qf.lnum == 0 and qf.col == 0 then
      table.insert(lines, qf.text)
    else
      local padded_fname = fname .. string.rep(" ", max_fname - vim.fn.strwidth(fname))

      local lnum = tostring(qf.lnum or "")
      local padded_lnum = string.rep(" ", max_lnum - vim.fn.strwidth(lnum)) .. lnum

      local col = tostring(qf.col or "")
      local padded_col = col .. string.rep(" ", max_col - vim.fn.strwidth(col))

      table.insert(lines, string.format("%s |%s:%s| %s", padded_fname, padded_lnum, padded_col, qf.text))
    end
  end

  return lines
end

return M
