local function cabal_format()
  vim.cmd("silent w | silent !cabal-gild -i % -o %")
end

if vim.fn.executable("cabal-gild") == 1 then
  vim.api.nvim_create_user_command("CabalFormat", cabal_format, {})
  vim.keymap.set("n", "<leader>F", ":CabalFormat<CR>", { buffer = true })
end

