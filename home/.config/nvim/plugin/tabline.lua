function _G.Tabline()
  local s = ""
  local cur = vim.fn.tabpagenr()

  for i = 1, vim.fn.tabpagenr("$") do
    local hl = (i == cur) and "%#TabLineSel#" or "%#TabLine#"
    s = s .. hl .. "%" .. i .. "T " .. i .. " %T"
  end

  return s .. "%#Normal#"
end

vim.o.tabline = "%!v:lua.Tabline()"
