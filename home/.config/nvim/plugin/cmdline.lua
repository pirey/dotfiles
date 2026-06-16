local function cmdsplit(mod)
  -- command that has s variant
  -- e.g. :sfind :sb etc
  local svariant = { "find", "b" }

  return function()
    local cmd = vim.fn.getcmdline()

    local sprefix = ""
    for _, v in pairs(svariant) do
      if cmd:match("^" .. v .. " ") then
        sprefix = "s"
      end
    end

    return "<c-b>" .. mod .. " " .. sprefix .. "<cr>"
  end
end

local function bufdelete()
  local cmd = vim.fn.getcmdline()
  local buf = cmd:match("^b (.+)$")
  if buf then
    vim.fn.setcmdline("bd " .. buf)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, false, true), "n", true)
  end
end

vim.keymap.set("c", "<c-v>", cmdsplit("vert"), { silent = true, expr = true })
vim.keymap.set("c", "<c-s>", cmdsplit("hor"), { silent = true, expr = true })
vim.keymap.set("c", "<c-t>", cmdsplit("tab"), { silent = true, expr = true })
vim.keymap.set("c", "<c-x>", bufdelete, { silent = true })
