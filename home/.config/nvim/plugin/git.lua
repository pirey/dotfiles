vim.api.nvim_create_user_command("GitCommit", function(args)
  local noargs = args.args == ""
  local porcelain = vim.fn.system("git status --porcelain 2>/dev/null")
  if vim.v.shell_error ~= 0 or vim.trim(porcelain) == "" then
    vim.notify("nothing to commit", vim.log.levels.WARN)
    return
  end
  if noargs then
    vim.cmd("tabnew | file COMMIT_EDITMSG | setl bufhidden=wipe filetype=gitcommit buftype=acwrite")
    local bufnr = vim.api.nvim_get_current_buf()
    local winid = vim.api.nvim_get_current_win()
    local status = vim.fn.system("git status")
    if vim.v.shell_error == 0 then
      local lines = vim.split(status, "\n", { trimempty = true })
      local pre = { "" }
      for _, l in ipairs(lines) do
        pre[#pre + 1] = l == "" and "#" or "# " .. l
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, pre)
      vim.api.nvim_win_set_cursor(0, { 1, 0 })
    end
    vim.api.nvim_create_autocmd("BufWriteCmd", {
      buffer = bufnr,
      once = true,
      callback = function()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local msg = {}
        for _, l in ipairs(lines) do
          if not l:match("^#") then
            msg[#msg + 1] = l
          end
        end
        while #msg > 0 and msg[#msg]:match("^%s*$") do
          msg[#msg] = nil
        end
        if #msg == 0 then
          return
        end
        local out = vim.fn.system("git commit -F - 2>&1", table.concat(msg, "\n"))
        if vim.v.shell_error ~= 0 then
          vim.cmd("tabnew | setl bufhidden=wipe readonly")
          vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(out, "\n", { trimempty = true }))
        end
        vim.defer_fn(function()
          if vim.api.nvim_win_is_valid(winid) then
            vim.api.nvim_win_close(winid, true)
          end
        end, 0)
      end,
    })
  else
    local out = vim.fn.system("git commit -m " .. vim.fn.shellescape(args.args) .. " 2>&1")
    if vim.v.shell_error ~= 0 then
      vim.cmd("tabnew | setl bufhidden=wipe readonly")
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(out, "\n", { trimempty = true }))
    end
  end
end, { nargs = "*" })

vim.api.nvim_create_user_command("GitPush", function(args)
  vim.fn.system("git push " .. args.args .. " 2>&1")
end, { nargs = "*" })

vim.cmd([[
  cabbrev <expr> gc getcmdtype() == ':' && getcmdline() =~# '^gc' ? 'GitCommit' : 'gc'
]])
