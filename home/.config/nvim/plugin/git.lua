vim.cmd([[
  cabbrev <expr> gc getcmdtype() == ':' && getcmdline() =~# '^gc' ? '!git commit -m' : 'gc'
  cabbrev <expr> gw getcmdtype() == ':' && getcmdline() =~# '^gw' ? '!git add %' : 'gw'
]])
