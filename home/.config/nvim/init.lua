vim.g.mapleader = " "

vim.o.wrap = false
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.gdefault = true

vim.o.splitright = true
vim.o.signcolumn = "yes"
vim.o.tabclose = "left"
vim.o.foldmethod = "indent"
vim.o.foldlevelstart = 99
vim.o.winborder = "rounded"
vim.o.pumborder = vim.o.winborder
vim.o.pumheight = 10
vim.o.fillchars = "diff: "
vim.o.wildoptions = "pum,tagfile,fuzzy"
vim.o.switchbuf = "uselast,useopen,usetab"

-- normalize
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

vim.keymap.set("n", "<leader>z", "<cmd>confirm bd<cr>", { silent = true })
vim.keymap.set("n", "<leader>x", "<cmd>tabclose<cr>", { silent = true })
vim.keymap.set("n", "<leader>c", "<cmd>silent copen<cr>")
vim.keymap.set("n", "<leader>l", "<cmd>silent lopen<cr>")

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

vim.cmd([[
cabbrev <expr> vsf getcmdtype() == ':' && getcmdline() =~# '^vsf' ? 'vert sfind' : 'vsf'
cabbrev <expr> sg getcmdtype() == ':' && getcmdline() =~# '^sg' ? 'silent grep!' : 'sg'
augroup Init
  autocmd!
  autocmd TermOpen * startinsert
  autocmd WinEnter * if &buftype == 'terminal' | startinsert | endif
augroup END
]])

require("vim._core.ui2").enable()
require("pack").setup(require("specs"))
vim.cmd.colorscheme("onedark")
