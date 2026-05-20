local function customize_default_colorscheme()
  -- stylua: ignore
  if vim.g.colors_name ~= nil then return end

  if vim.o.background == "dark" then
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NvimDarkGrey3" })
  elseif vim.o.background == "light" then
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NvimLightGrey3" })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "default",
  callback = customize_default_colorscheme,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = customize_default_colorscheme,
})

customize_default_colorscheme()
