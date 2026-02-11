vim.g.mapleader = " "

-- essentials
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- nice to have
vim.opt.splitright = true
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.scrolloff = 3
vim.opt.tabclose = "left"
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.winborder = "rounded"
vim.opt.fillchars:append({ diff = " " })
vim.opt.wildoptions:append({ "fuzzy" })
vim.opt.switchbuf = { "uselast", "useopen", "usetab" }

-- ignore .git by default so we doesn't need to specify it when using --hidden
vim.opt.grepprg = "rg --hidden --vimgrep --smart-case --glob=!.git"

vim.keymap.set({ "n", "v" }, ";", ":", { desc = "Swap ; with :" })
vim.keymap.set({ "n", "v" }, ":", ";", { desc = "Swap : with ;" })
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")
vim.keymap.set("v", "<c-c>", '"+y', { silent = true, desc = "Copy to clipboard" })
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted text" })
vim.keymap.set("n", "<leader>x", "<cmd>confirm bd<cr>", { silent = true })

-- terminal
vim.keymap.set("n", "<leader>te", "<cmd>term<cr>", { silent = true })
vim.keymap.set("n", "<leader>tb", "<cmd>bot term<cr>", { silent = true })
vim.keymap.set("n", "<leader>tv", "<cmd>vert term<cr>", { silent = true })
vim.keymap.set("n", "<leader>ts", "<cmd>below term<cr>", { silent = true })
vim.keymap.set("n", "<leader>t<tab>", "<cmd>tab term<cr>", { silent = true })
vim.keymap.set("n", "<localleader>te", "<cmd>lcd %:h | term<cr>", { silent = true })
vim.keymap.set("n", "<localleader>tb", "<cmd>bot sp | lcd %:h | term<cr>", { silent = true })
vim.keymap.set("n", "<localleader>tv", "<cmd>vert sp | lcd %:h | term<cr>", { silent = true })
vim.keymap.set("n", "<localleader>ts", "<cmd>below sp | lcd %:h | term<cr>", { silent = true })
vim.keymap.set("n", "<localleader>t<tab>", "<cmd>tab sp | lcd %:h | term<cr>", { silent = true })

-- tabpage
vim.keymap.set("n", "<leader><tab>c", "<cmd>tabclose<cr>", { silent = true })
vim.keymap.set("n", "<leader><tab>o", "<cmd>tabonly<cr>", { silent = true })
vim.keymap.set("n", "<leader><tab>l", "<cmd>tabs<cr>", { silent = true })
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnew<cr>", { silent = true })
vim.keymap.set("n", "]<tab>", "gt", { silent = true })
vim.keymap.set("n", "[<tab>", "gT", { silent = true })

vim.keymap.set("c", "<C-j>", "<Down>", { noremap = true })
vim.keymap.set("c", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set({ "n" }, [[\\]], [[<c-\><c-n><C-w><C-w>]], {
  silent = true,
  noremap = true,
  desc = "Alternate window",
})
vim.keymap.set({ "n", "i", "t" }, [[<C-\><C-\>]], [[<c-\><c-n><C-w><C-w>]], {
  silent = true,
  noremap = true,
  desc = "Alternate window",
})

vim.cmd("autocmd TermOpen * startinsert")
vim.cmd("autocmd WinEnter * if &buftype == 'terminal' | startinsert | endif")
vim.cmd("autocmd QuickFixCmdPost grep,grep! copen")

-- experimental
if vim.fn.has("nvim-0.12") == 1 then
  vim.opt.pumborder = vim.o.winborder

  if vim.env.PLUG ~= "0" then
    require("pack").setup(require("specs"))
    vim.cmd.colorscheme("nightfox")
  end
else
  print("nvim-0.12 is required to use vim.pack")
end
