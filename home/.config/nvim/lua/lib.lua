local M = {}

function M.in_git_repo()
  return vim.fn.executable("git") == 1
    and vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match("true")
end

function M.get_buffer_files()
  local files = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buflisted then
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name ~= "" then
        files[#files + 1] = vim.fn.fnamemodify(name, ":.")
      end
    end
  end
  return files
end

local function get_modified_files()
  if not M.in_git_repo() then
    return {}
  end
  local lines = vim.fn.systemlist("git status --porcelain")
  local files = {}
  for _, line in ipairs(lines) do
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
      if vim.fn.filereadable(f) == 1 then
        table.insert(result, rel)
      end
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

function M.smart_recent()
  local modified_files = get_modified_files()
  local buffer_files = M.get_buffer_files()
  local oldfiles = get_oldfiles_cwd()
  return uniq(vim.list_extend(vim.list_extend(modified_files, buffer_files), oldfiles))
end

return M
