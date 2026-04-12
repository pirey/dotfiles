vim.g.mapleader = " "

vim.o.wrap = false
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.gdefault = true

vim.o.splitright = true
vim.o.number = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.tabclose = "left"
vim.o.foldmethod = "indent"
vim.o.foldlevelstart = 99
vim.o.winborder = "rounded"
vim.o.pumborder = vim.o.winborder
vim.o.fillchars = "diff: "
vim.o.wildoptions = vim.o.wildoptions .. ",fuzzy"

-- ignore .git by default so we doesn't need to specify it when using --hidden
vim.o.grepprg = "rg --hidden --vimgrep --smart-case --glob=!.git"

vim.keymap.set({ "n", "v" }, ";", ":", { desc = "Swap ; with :" })
vim.keymap.set({ "n", "v" }, ":", ";", { desc = "Swap : with ;" })
vim.keymap.set("v", "<c-c>", '"+y', { silent = true, desc = "Copy to system clipboard" })
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted text" })

-- navigation
vim.keymap.set("c", "<C-j>", "<Down>", { noremap = true })
vim.keymap.set("c", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set({ "n", "i", "t" }, [[<C-\><C-\>]], [[<c-\><c-n><C-w><C-w>]], {
  silent = true,
  noremap = true,
  desc = "Alternate window",
})
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "]q", function()
  vim.cmd("cnext")
  vim.cmd("normal zz")
  vim.cmd("cwindow")
end)
vim.keymap.set("n", "[q", function()
  vim.cmd("cprevious")
  vim.cmd("normal zz")
  vim.cmd("cwindow")
end)
vim.keymap.set("n", "]l", function()
  vim.cmd("lnext")
  vim.cmd("normal zz")
  vim.cmd("lwindow")
end)
vim.keymap.set("n", "[l", function()
  vim.cmd("lprevious")
  vim.cmd("normal zz")
  vim.cmd("lwindow")
end)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<cr>", "<cr><cmd>cclose<cr>", { buffer = true })
    vim.keymap.set("n", "<cr>", "<cr><cmd>cclose<cr>", { buffer = true })
  end,
})

vim.keymap.set("n", "<leader>z", "<cmd>confirm bd<cr>", { silent = true })
vim.keymap.set("n", "<leader>x", "<cmd>tabclose<cr>", { silent = true })

-- terminal
vim.keymap.set("n", "<leader>te", "<cmd>term<cr>", { silent = true })
vim.keymap.set("n", "<leader>tb", "<cmd>bot term<cr>", { silent = true })
vim.keymap.set("n", "<leader>tv", "<cmd>vert term<cr>", { silent = true })
vim.keymap.set("n", "<leader>ts", "<cmd>below term<cr>", { silent = true })
vim.keymap.set("n", "<leader>tt", "<cmd>tab term<cr>", { silent = true })
vim.keymap.set("n", "<localleader>te", "<cmd>lcd %:h | term<cr>", { silent = true })
vim.keymap.set("n", "<localleader>tb", "<cmd>bot sp | lcd %:h | term<cr>", { silent = true })
vim.keymap.set("n", "<localleader>tv", "<cmd>vert sp | lcd %:h | term<cr>", { silent = true })
vim.keymap.set("n", "<localleader>ts", "<cmd>below sp | lcd %:h | term<cr>", { silent = true })
vim.keymap.set("n", "<localleader>tt", "<cmd>tab sp | lcd %:h | term<cr>", { silent = true })

-- tabpage
vim.keymap.set("n", "<leader><tab>o", "<cmd>tabonly<cr>", { silent = true })
vim.keymap.set("n", "]<tab>", "gt", { silent = true })
vim.keymap.set("n", "[<tab>", "gT", { silent = true })

-- fold
vim.keymap.set({ "n", "x" }, "zk", "zk[z", { silent = true, desc = "To start of prev fold" })

vim.cmd("autocmd TermOpen * startinsert")
vim.cmd("autocmd WinEnter * if &buftype == 'terminal' | startinsert | endif")
-- vim.cmd("autocmd QuickFixCmdPost grep,grep! copen")

require("vim._core.ui2").enable()
require("pack").setup(require("specs"))
vim.cmd.colorscheme("nightfox")
