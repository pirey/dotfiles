local function set_hl()
  if vim.g.colors_name ~= nil then
    return
  end

  if vim.o.background == "dark" then
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NvimDarkGrey3" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NvimDarkGrey1" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NvimDarkGrey1", fg = "NvimDarkGrey4" })
    vim.api.nvim_set_hl(0, "NonText", { fg = "NvimDarkGrey2" })
  elseif vim.o.background == "light" then
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NvimLightGrey3" })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "default",
  callback = set_hl,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = set_hl,
})

set_hl()
