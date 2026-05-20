local function customize_default_colorscheme()
  -- stylua: ignore
  if vim.g.colors_name ~= nil then return end

  if vim.o.background == "dark" then
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NvimDarkGrey3" })
    vim.api.nvim_set_hl(0, "DiffAdd", { fg = "NONE", bg = "#1a3a2a" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NvimDarkGrey1" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NvimDarkGrey1", fg = "NvimDarkGrey4" })
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
