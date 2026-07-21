local config = require("config")
local lib = require("lib")

local function find_glob(cmdarg, cmdcomplete)
  local pat = cmdcomplete == 1 and (cmdarg .. "*") or cmdarg
  return vim.fn.glob(pat, false, true)
end

local function find_git_files(cmdarg)
  local files = vim.fn.systemlist("git ls-files --cached --others --exclude-standard")
  if cmdarg == "" then
    return files
  end
  return vim.fn.matchfuzzy(files, cmdarg)
end

local function find_fd_files(cmdarg)
  local files = vim.fn.systemlist("fd --hidden --exclude .git")
  if cmdarg == "" then
    return files
  end
  return vim.fn.matchfuzzy(files, cmdarg)
end

function _G.FindSmart(cmdarg, cmdcomplete)
  if not config.opts.enable_cmdline_completion then
    if cmdcomplete and cmdarg == "" then
      return lib.smart_recent()
    end
  end

  local files = {}

  if vim.fn.executable("fd") == 1 then
    files = find_fd_files(cmdarg)
  elseif lib.in_git_repo() then
    files = find_git_files(cmdarg)
  else
    files = find_glob(cmdarg, cmdcomplete)
  end

  return files
end

if config.opts.enable_cmdline_completion then
  vim.keymap.set("n", "<leader>f", ":find ")
else
  vim.cmd([[
    set wildcharm=<Nul>
    nnoremap <leader>f :find <Nul><c-p>
  ]])
end

vim.cmd([[
  cabbrev <expr> fd getcmdtype() == ':' && getcmdline() =~# '^fd' ? 'find' : 'fd'
]])

vim.o.findfunc = "v:lua.FindSmart"
