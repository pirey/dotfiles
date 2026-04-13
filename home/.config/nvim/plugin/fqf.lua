local function is_git_repo()
  return vim.fn.executable("git") == 1
    and vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match("true")
end

local M = {}

function M.find_files()
  local lines

  if is_git_repo() then
    lines = vim.fn.systemlist("git ls-files --cached --others --exclude-standard")
  else
    -- TODO: use vim.uv.fs_scandir
    lines = vim.fs.find(function(_, path)
      return not path:match(".git/?.*")
    end, {
      path = vim.uv.cwd(),
      limit = math.huge,
      type = "file",
      hidden = true,
    })
  end

  -- TODO: chunk items
  local items = vim.tbl_map(function(f)
    return { filename = f, lnum = 1, col = 1 }
  end, lines)

  vim.fn.setqflist({}, "r", { title = "Files", items = items })
  vim.cmd("copen")
end

vim.api.nvim_create_user_command("FQF", function()
  M.find_files()
end, {})
