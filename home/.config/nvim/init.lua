vim.g.mapleader = " "

vim.o.wrap = false
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.gdefault = true
vim.o.signcolumn = "yes"
vim.o.pumheight = 10
vim.o.splitright = true
vim.o.tabclose = "left"
vim.o.wildoptions = vim.o.wildoptions .. ",fuzzy"

-- normalize
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "Swap ; with :" })
vim.keymap.set({ "n", "v" }, ":", ";", { desc = "Swap : with ;" })
vim.keymap.set("v", "<c-c>", '"+y', { silent = true, desc = "Copy to system clipboard" })
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted text" })

-- navigation
vim.keymap.set("c", "<C-j>", "<Down>", { noremap = true })
vim.keymap.set("c", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set({ "n", "i", "t" }, [[<C-\><C-\>]], [[<c-\><c-n>]], {
  silent = true,
  noremap = true,
  desc = "Enter terminal normal mode",
})
vim.keymap.set({ "n", "i", "t" }, [[<C-\>w]], [[<c-\><c-n><C-w><C-w>]], {
  silent = true,
  noremap = true,
  desc = "Alternate window",
})
vim.keymap.set({ "n", "i", "t" }, [[<C-\><C-u>]], [[<c-\><c-n><C-u>]], {
  silent = true,
  noremap = true,
  desc = "Scroll Up",
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
vim.keymap.set({ "n", "t" }, "]<tab>", "<cmd>tabnext<cr>", { silent = true })
vim.keymap.set({ "n", "t" }, "[<tab>", "<cmd>tabprevious<cr>", { silent = true })

vim.cmd("autocmd TermOpen * startinsert")
vim.cmd("autocmd WinEnter * if &buftype == 'terminal' | startinsert | endif")

require("vim._core.ui2").enable()
require("specs")
