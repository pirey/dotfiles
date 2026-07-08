local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  buffer_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
  end,
  screen_width = function(min_w)
    return function()
      return vim.o.columns > min_w
    end
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  diff_mode = function()
    return vim.o.diff == true
  end,
}

local branch = {
  "branch",
  icon = "",
  color = { gui = "bold" },
}

local filename = {
  "filename",
  path = 1,
}

local lsp = {
  "lsp_status",
  cond = conditions.screen_width(120),
}

local diff = {
  "diff",
  cond = conditions.screen_width(120),
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  -- colored = false,
  -- symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
  cond = conditions.screen_width(120),
}

local cwd = {
  function()
    return "󰉋 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  end,
  color = { gui = "bold" },
}

local macro = {
  function()
    local char_register = vim.fn.reg_recording()
    if #char_register > 0 then
      return "REC @" .. char_register
    end
    return ""
  end,
  color = "Cursor",
}

local selectioncount = {
  "selectioncount",
  color = "Cursor",
}

local location = {
  "location",
}

local progress = {
  "progress",
}

local tabs = {
  "tabs",
  tabs_color = {
    active = "Cursor",
    inactive = "StatusLine",
  },
  show_modified_status = false,
  cond = function()
    local tabcount = #vim.api.nvim_list_tabpages()
    return tabcount > 1
  end,
}

return {
  src = "nvim-lualine/lualine.nvim",
  config = function()
    vim.o.showtabline = 0
    require("lualine").setup({
      options = {
        theme = {
          normal = {
            a = "StatusLine",
            b = "StatusLine",
            c = "StatusLine",
            -- TODO: find out if these are necessary, remove otherwise
            -- x = "StatusLine",
            -- y = "StatusLine",
            -- z = "StatusLine",
          },
        },
        globalstatus = true,
        always_divide_middle = false,
        always_show_tabline = false,
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_a = { tabs, cwd },
        lualine_b = {},
        lualine_c = {
          filename,
        },
        lualine_x = {
          lsp,
          diagnostics,
          selectioncount,
          -- searchcount,
          macro,
        },
        lualine_y = {
          diff,
          branch,
          location,
          progress,
        },
        lualine_z = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    })
  end,
}
