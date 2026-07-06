if true then return end
vim.o.cmdheight = 0
vim.o.laststatus = 0

local exclude_buftypes = { 'quickfix', 'nofile', 'help', 'terminal', 'prompt' }

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
  callback = function()
    if vim.tbl_contains(exclude_buftypes, vim.bo.buftype) or vim.api.nvim_buf_get_name(0) == '' then
      vim.wo.winbar = ''
    else
      vim.wo.winbar = "%= %t %m %="
    end
  end,
})

