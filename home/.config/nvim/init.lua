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
vim.o.pumheight = 10
vim.o.fillchars = "diff: "
vim.o.wildoptions = vim.o.wildoptions .. ",fuzzy"

-- ignore .git by default so we doesn't need to specify it when using --hidden
vim.o.grepprg = "rg --hidden --vimgrep --smart-case --glob=!.git"

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
vim.keymap.set("n", "<leader>c", "<cmd>copen<cr>", { silent = true })
vim.keymap.set("n", "<leader>l", "<cmd>lopen<cr>", { silent = true })

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
augroup InitAugroup
  autocmd!
  autocmd TermOpen * startinsert
  autocmd WinEnter * if &buftype == 'terminal' | startinsert | endif
  autocmd QuickFixCmdPre grep copen
augroup END
]])

local fqf = require("fqf")
fqf.setup()
vim.keymap.set("n", "<leader>f", fqf.builtins.files)
vim.keymap.set("n", "<leader>p", fqf.builtins.smart_files)
vim.keymap.set("n", "<leader><leader>d", fqf.builtins.dirs)
vim.keymap.set("n", "<leader>,", fqf.builtins.live_grep)
vim.keymap.set("n", "<leader><leader>,", fqf.builtins.grep)
vim.keymap.set("n", "<leader>'", fqf.builtins.oldfiles)
vim.keymap.set("n", "<leader>gq", fqf.builtins.git_changes)
vim.keymap.set("n", "<leader>/", fqf.builtins.buffer_lines)

require("vim._core.ui2").enable()
require("pack").setup(require("specs"))
vim.cmd.colorscheme("nightfox")
