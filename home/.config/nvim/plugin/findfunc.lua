local function in_git_repo()
  return vim.fn.executable("git") == 1
    and vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match("true")
end

local function get_modified_files()
  if not in_git_repo() then
    return {}
  end

  local lines = vim.fn.systemlist("git status --porcelain")
  local files = {}

  for _, line in ipairs(lines) do
    -- format: XY path OR XY old -> new
    local path = line:sub(4)
    local renamed = path:match("-> (.+)$")
    table.insert(files, renamed or path)
  end

  return files
end

local function get_oldfiles_cwd()
  local cwd = vim.fn.getcwd()
  local result = {}

  for _, f in ipairs(vim.v.oldfiles or {}) do
    if f:sub(1, #cwd) == cwd then
      local rel = f:sub(#cwd + 2)
      table.insert(result, rel)
    end
  end

  return result
end

local function uniq(list)
  local res = {}
  local seen = {}

  for _, v in ipairs(list) do
    if not seen[v] then
      seen[v] = true
      table.insert(res, v)
    end
  end

  return res
end

local function find_glob(cmdarg, cmdcomplete)
  local pat = cmdcomplete == 1 and (cmdarg .. "*") or cmdarg
  return vim.fn.glob(pat, false, true)
end

local function find_git_files(cmdarg, cmdcomplete)
  local files = vim.fn.systemlist("git ls-files --cached --others --exclude-standard")
  return vim.fn.matchfuzzy(files, cmdarg)
end

local function find_fd_files(cmdarg, cmdcomplete)
  local files = vim.fn.systemlist("fd --hidden --exclude .git --type f")

  return vim.fn.matchfuzzy(files, cmdarg)
end

function _G.FindSmart(cmdarg, cmdcomplete)
  local files = {}

  if vim.fn.executable("fd") then
    files = find_fd_files(cmdarg, cmdcomplete)
  elseif in_git_repo() then
    files = find_git_files(cmdarg, cmdcomplete)
  else
    files = find_glob(cmdarg, cmdcomplete)
  end

  if cmdcomplete and cmdarg == "" then
    local modified_files = get_modified_files()
    local oldfiles = get_oldfiles_cwd()
    return uniq(vim.list_extend(vim.list_extend(modified_files, oldfiles), files))
  end

  return files
end

vim.api.nvim_set_option_value("findfunc", "v:lua.FindSmart", {})
