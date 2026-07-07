local util = {}

function util.truncate_string(s, opts)
  opts = vim.tbl_extend("force", {
    should_truncate = true,
    maxlen = 0,
  }, opts or {})
  if opts.should_truncate and opts.maxlen == 0 then
    return ""
  end
  if opts.should_truncate and vim.api.nvim_strwidth(s) >= opts.maxlen then
    local trimmed = string.sub(s, 1, opts.maxlen)
    local pattern = "[-_]$"
    s = string.gsub(trimmed, pattern, "") .. ".."
  end
  return s
end

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
  fmt = function(s)
    if #s == 0 then
      return ""
    end

    -- PERF: is it ok to run this on each render
    local h = vim.api.nvim_get_hl(0, {
      name = "StatusLine",
    })
    vim.api.nvim_set_hl(0, "LualineBranch", {
      bold = true,
      bg = h.bg,
      fg = h.fg,
    })
    -- s = util.truncate_string(s, {
    --   maxlen = 15,
    --   -- should_truncate = vim.o.columns < 150,
    -- })
    return "%#LualineBranch#" .. s
  end,
}

local diff = {
  "diff",
  -- symbols = { added = " ", modified = " ", removed = " " },
  -- colored = false,
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

local nofile = {
  function()
    -- PERF: is it ok to run this on each render
    local h = vim.api.nvim_get_hl(0, {
      name = "StatusLine",
    })
    vim.api.nvim_set_hl(0, "LualineNoFile", {
      bold = true,
      bg = h.bg,
      fg = h.fg,
    })
    local s = " neovim"
    return "%#LualineNoFile#" .. s
  end,
  cond = conditions.buffer_empty,
}

local winbar_filename = {
  "filename",
  path = 0,
  shorting_target = vim.fn.winwidth(0) / 2,
  symbols = {
    modified = "●",
  },
  cond = conditions.buffer_not_empty,
}

-- local filename_pretty = {
--   require("lazyvim.util").lualine.pretty_path({
--     -- modified_hl = "Bold", -- same highlight as filename_hl
--     modified_sign = " ●",
--     length = 6,
--     readonly_icon = " RO ",
--   }),
--   fmt = function(s)
--     local no_hl = string.gsub(s, "%%#.-#", "")
--     local breakpoint_percent = 0.50
--     return util.truncate_string(s, {
--       should_truncate = #no_hl > math.floor(vim.o.columns * breakpoint_percent),
--     })
--   end,
-- }

local cwd = {
  function()
    return "󰉋 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  end,
}

local separator = {
  "%=",
}

local space = {
  function()
    return " "
  end,
}

local macro = {
  function()
    local char_register = vim.fn.reg_recording()
    if #char_register > 0 then
      return "[REC @" .. char_register .. "]"
    end
    return ""
  end,
  color = "Visual",
}

local searchcount = {
  "searchcount",
  color = "Search",
  -- fmt = function(s)
  --   if s == "" or s == "[0/0]" then
  --     return ""
  --   end
  --   local search_pattern = vim.fn.getreg("/")
  --   return "SEARCH: " .. search_pattern .. " " .. s
  -- end,
}

local selectioncount = {
  "selectioncount",
  color = "Visual",
}

local location = {
  "location",
}

local max_line = {
  function()
    return vim.fn.line("$")
  end,
  cond = conditions.buffer_not_empty,
}

local encoding = {
  "encoding",
}

local filetype = {
  -- "%y",
  "filetype",
  cond = conditions.screen_width(120),
  -- colored = false,
}
local filetype_icon = {
  "filetype",
  icon_only = true,
}

local progress = {
  "progress",
}

local noicecmd = {
  function()
    return require("noice").api.status.command.get()
  end,
  cond = function()
    return package.loaded["noice"] and require("noice").api.status.command.has()
  end,
  -- color = function()
  --   return LazyVim.ui.fg("Statement")
  -- end,
}

local tmux_char = {
  function()
    local result = io.popen("tmux list-panes -F '#F' | grep Z")

    if result ~= nil and result:read("*a") ~= "" then
      result:close()
      return "■■"
    else
      return "■"
    end
  end,
  padding = { left = 1, right = 1 }, -- We don't need space before this
  cond = function()
    return os.getenv("TMUX") ~= nil
  end,
  on_click = function()
    os.execute("tmux resize-pane -Z")
  end,
}

local tabs = {
  "tabs",
  tabs_color = {
    active = "Cursor",
    inactive = "Visual",
  },
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
            -- b = "Visual",
            -- c = "CursorLine",
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
        disabled_filetypes = {
          statusline = { "neo-tree", "git", "fugitive", "toggleterm", "trouble" },
          winbar = { "neo-tree", "DiffviewFiles", "git" },
        },
      },
      sections = {
        lualine_a = { cwd },
        lualine_b = {},
        lualine_c = {
          -- filetype_icon,
          -- filename,
          "%f",
          "%m",
          -- filename_pretty,
        },
        lualine_x = {
          diagnostics,
          -- noicecmd,
          selectioncount,
          searchcount,
          macro,
        },
        lualine_y = { diff, branch },
        lualine_z = {
          location,
          progress,
          tabs,
          -- tmux_char,
        },
      },
      winbar = {
        lualine_c = {
          -- winbar_filename,
        },
      },
      inactive_winbar = {
        lualine_c = {
          -- winbar_filename,
        },
      },
      -- tabline = {
      --   lualine_x = {
      --     tabs,
      --     separator,
      --   },
      -- },
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
