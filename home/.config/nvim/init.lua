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
vim.o.list = true
vim.o.showbreak = "↪ "
vim.o.confirm = true

vim.o.number = true
vim.o.cursorline = true
vim.o.foldmethod = "indent"
vim.o.foldlevelstart = 99
vim.o.shortmess = vim.o.shortmess .. "I"
vim.o.winborder = "single"

-- normalize
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "Swap ; with :" })
vim.keymap.set({ "n", "v" }, ":", ";", { desc = "Swap : with ;" })
vim.keymap.set("v", "<c-c>", '"+y', { silent = true, desc = "Copy to system clipboard" })
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted text" })
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

-- navigation
vim.keymap.set("c", "<C-j>", "<Down>", { noremap = true })
vim.keymap.set("c", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set({ "n", "i", "t" }, [[<C-\><C-\>]], [[<c-\><c-n>]], {
  silent = true,
  noremap = true,
  desc = "Enter terminal normal mode",
})
vim.keymap.set({ "n", "i", "t" }, [[<C-\><C-w>]], [[<c-\><c-n><C-w><C-w>]], {
  silent = true,
  noremap = true,
  desc = "Alternate window",
})
vim.keymap.set({ "n", "i", "t" }, [[<C-\><C-u>]], [[<c-\><c-n><C-u>]], {
  silent = true,
  noremap = true,
  desc = "Scroll Up",
})

-- helix keymap
vim.keymap.set({ "n", "v" }, "gh", "0")
vim.keymap.set({ "n" }, "gl", "$")
vim.keymap.set({ "v" }, "gl", "$h")
vim.keymap.set({ "n", "v" }, "ge", "G")
vim.keymap.set({ "n", "x" }, "mm", "%", { remap = true })
vim.keymap.set({ "x" }, "am", "a%", { remap = true })
vim.keymap.set("n", "ga", "<cmd>b#<cr>")

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
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnew<cr>", { silent = true })
vim.keymap.set("n", "<leader><tab>o", "<cmd>tabonly<cr>", { silent = true })
vim.keymap.set({ "n", "t" }, "]<tab>", "<cmd>tabnext<cr>", { silent = true })
vim.keymap.set({ "n", "t" }, "[<tab>", "<cmd>tabprevious<cr>", { silent = true })

-- etc
vim.keymap.set("n", "<leader>x", "<cmd>tabclose<cr>", { silent = true })
vim.keymap.set("n", "<leader>X", "<cmd>confirm %bd<cr>", { silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>", { desc = "Toggle wrap" })
vim.keymap.set("n", "<leader>z", "za", { desc = "Toggle fold" })
vim.keymap.set("n", "<leader><leader>z", function()
  if vim.wo.foldlevel == 0 then
    vim.cmd("normal! zR")
  else
    vim.cmd("normal! zM")
  end
end, { desc = "Toggle all folds" })

vim.cmd("autocmd TermOpen * startinsert")
vim.cmd("autocmd WinEnter * if &buftype == 'terminal' | startinsert | endif")

require("vim._core.ui2").enable()
require("specs")

vim.cmd.colorscheme("onedark")
