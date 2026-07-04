local function set_hl(arg)
  if arg and arg.event == "ColorScheme" then
    if arg.match ~= "default" then
      return
    end
  end

  if arg and arg.event == "OptionSet" then
    if vim.g.colors_name ~= nil then
      return
    end
  end

  if vim.o.background == "dark" then
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NvimDarkGrey3" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NvimDarkGrey1" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NvimDarkGrey1", fg = "NvimDarkGrey4" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "NvimDarkGrey2" })
    vim.api.nvim_set_hl(0, "Whitespace", { fg = "NvimDarkGrey3" })
    vim.api.nvim_set_hl(0, "DiffAdd", { fg = "NONE", bg = "NvimDarkGreen" })
    -- vim.api.nvim_set_hl(0, "DiffDelete", { fg = "NONE", bg = "NvimDarkRed" })
    vim.api.nvim_set_hl(0, "DiffChange", { fg = "NONE", bg = "NvimDarkCyan" })
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
