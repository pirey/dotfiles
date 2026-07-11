local config = require("config")
local augroup = vim.api.nvim_create_augroup("SpecsAugroup", { clear = true })

local jump = {
  src = "yorickpeterse/nvim-jump",
  config = function()
    require("jump").setup()
    vim.keymap.set({ "n", "x" }, "s", function()
      require("jump").start()
    end)
  end,
}
local surround = {
  src = "tpope/vim-surround",
  dependencies = { { src = "tpope/vim-repeat" } },
}
local abolish = { src = "tpope/vim-abolish" }
local mason = {
  src = "mason-org/mason.nvim",
  config = function()
    require("mason").setup()
    local registry = require("mason-registry")

    local ensure_installed = {
      "lua-language-server",
      "prettier",
      "prettierd",
      "tailwindcss-language-server",
      "vtsls",
      "phpactor",
      "php-cs-fixer",
      "blade-formatter",
      "stylua",
      "gopls",
    }

    for _, tool in ipairs(ensure_installed) do
      local p = registry.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end,
}
local treesj = {
  src = "Wansmer/treesj",
  config = function()
    require("treesj").setup({ use_default_keymaps = false })
    vim.keymap.set("n", "<c-j>", "<cmd>TSJToggle<cr>", { silent = true, desc = "Join/split line" })
  end,
}
local treesitter = {
  src = "nvim-treesitter/nvim-treesitter",
  config = function()
    local ts = require("nvim-treesitter")
    local languages =
      { "haskell", "nix", "javascript", "typescript", "tsx", "lua", "html", "blade", "php", "diff", "go" }
    local activate_on_ft = vim.list_extend({
      "typescriptreact",
      "javascriptreact",
      "markdown",
      "c",
    }, languages)

    local installed = ts.get_installed()
    local task = ts.install(languages)

    task:await(function(err)
      if err then
        vim.notify("Treesitter install failed: " .. err, vim.log.levels.ERROR)
      else
        local installed_after = ts.get_installed()
        if #installed ~= #installed_after then
          vim.notify("Treesitter parsers installed!", vim.log.levels.INFO)
        end
      end
    end)

    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      pattern = activate_on_ft,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
local lspconfig = {
  src = "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            library = {
              vim.env.VIMRUNTIME,
            },
          },
        },
      },
    })
    vim.lsp.config("sourcekit", {
      cmd = { "xcrun", "sourcekit-lsp" },
      filetypes = { "swift" },
    })
    vim.lsp.config("phpactor", {
      init_options = {
        ["language_server.diagnostic_ignore_codes"] = {
          "worse.docblock_missing_return_type",
          "worse.docblock_missing_param",
          "worse.missing_return_type",
        },
      },
    })
    vim.lsp.config("vtsls", {
      settings = {
        typescript = {
          preferences = {
            importModuleSpecifier = "non-relative",
          },
        },
      },
    })
    vim.lsp.config("tailwindcss", {
      settings = {
        tailwindCSS = {
          lint = {
            suggestCanonicalClasses = "ignore",
          },
          classFunctions = { "tw", "clsx", "tw\\.[a-z-]+", "twMerge" },
        },
      },
    })

    local icons = require("icons")

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.get("error"),
          [vim.diagnostic.severity.WARN] = icons.get("warn"),
          [vim.diagnostic.severity.INFO] = icons.get("info"),
          [vim.diagnostic.severity.HINT] = icons.get("hint"),
        },
      },
    })

    vim.lsp.document_color.enable(true, {}, { style = "virtual" })

    vim.lsp.enable({
      "sourcekit",
      "lua_ls",
      "phpactor",
      "tailwindcss",
      "vtsls",
      "cssls",
      "gopls",
    })

    -- disable semantic highlight
    vim.api.nvim_create_autocmd("LspAttach", {
      group = augroup,
      callback = function(args)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, { buffer = args.buf })

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.semanticTokensProvider then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end,
    })
  end,
}
local fff = {
  src = "dmtrKovalenko/fff.nvim",
  config = function()
    vim.api.nvim_create_autocmd("PackChanged", {
      group = augroup,
      callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "fff.nvim" and (kind == "install" or kind == "update") then
          if not ev.data.active then
            vim.cmd.packadd("fff.nvim")
          end
          require("fff.download").download_or_build_binary()
        end
      end,
    })

    local layout = {
        prompt_position = "top",
        flex = { wrap = "bottom" },
    }

    if config.preset_fff == "simple" then
      layout = vim.tbl_extend('force', layout, {
        width = 0.4,
        height = 0.5,
        anchor = "bottom_left",
      })
    end

    vim.g.fff = {
      prompt = " ",
      title = "Files",
      layout = layout,
      preview = { enabled = config.preset_fff ~= "simple" },
      keymaps = {
        close = { "<esc>", "<c-c>" },
        cycle_grep_modes = "<c-_>",
        cycle_previous_query = "<c-k>",
      },
      icons = { enabled = false },
    }
    vim.keymap.set("n", "f ", function()
      require("fff").find_files()
    end)
    vim.keymap.set("n", "f,", function()
      require("fff").live_grep()
    end)
    vim.keymap.set("n", "f.", "<cmd>FFFResume<cr>")
  end,
}
local satellite = { src = "lewis6991/satellite.nvim" }
local illuminate = { src = "RRethy/vim-illuminate" }
local lualine = {
  src = "nvim-lualine/lualine.nvim",
  config = function()
    vim.o.showtabline = 0

    local icons = require("icons")

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      buffer_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) == 1
      end,
      max_width = function(max_w)
        return function()
          return vim.o.columns <= max_w
        end
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
      icon = icons.get("branch"),
    }

    local filename = {
      "filename",
      path = 1,
      symbols = {
        modified = icons.get("modified"),
        readonly = icons.get("readonly"),
      },
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
      symbols = icons.diagnostics_symbols(),
      cond = conditions.screen_width(120),
    }

    local cwd = {
      function()
        return icons.get("folder") .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      end,
    }

    local macro = {
      function()
        local char_register = vim.fn.reg_recording()
        if #char_register > 0 then
          return "REC @" .. char_register
        end
        return ""
      end,
    }

    local selectioncount = {
      "selectioncount",
    }

    local location = {
      "location",
    }

    local progress = {
      "progress",
    }

    local tabs = {
      "tabs",
      show_modified_status = false,
      cond = function()
        local tabcount = #vim.api.nvim_list_tabpages()
        return tabcount > 1
      end,
    }

    local orgmode_status = {
      function()
        ---@diagnostic disable-next-line: undefined-field
        return _G.orgmode.statusline()
      end,
      cond = conditions.screen_width(120),
    }

    local preset = config.preset_statusline

    -- default separators
    local section_seps = { left = "", right = "" }
    local component_seps = { left = "", right = "" }

    if preset == "bubble" then
      section_seps = { left = icons.sep("round_right_filled"), right = icons.sep("round_left_filled") }
    elseif preset == "slanted" then
      section_seps = { left = icons.sep("slant_right_filled"), right = icons.sep("slant_left_filled") }
    elseif preset == "slanted2" then
      section_seps = { left = icons.sep("slant_right_upper"), right = icons.sep("slant_left_upper") }
    elseif preset == "slanted3" then
      section_seps = { left = icons.sep("slant_right_upper"), right = icons.sep("slant_left_filled") }
    elseif preset == "asymmetric" then
      section_seps = { left = icons.sep("slant_right_upper"), right = icons.sep("round_left_filled") }
    elseif preset == "asymmetric2" then
      section_seps = { left = icons.sep("round_right_filled"), right = icons.sep("slant_left_upper") }
    end

    local function edge_component(component, side)
      side = side or "both" -- "left" | "right" | "both"
      if preset == "bubble" then
        return vim.tbl_extend("force", component, {
          separator = {
            left = side ~= "right" and " " .. icons.sep("round_left_filled") or "",
            right = side ~= "left" and icons.sep("round_right_filled") .. " " or "",
          },
        })
      end
      return component
    end

    require("lualine").setup({
      options = {
        globalstatus = true,
        always_divide_middle = false,
        always_show_tabline = false,
        component_separators = component_seps,
        section_separators = section_seps,
        theme = not preset or preset == "simple" and {
          normal = {
            a = "StatusLine",
            b = "StatusLine",
            c = "StatusLine",
          },
        } or "auto",
      },
      sections = {
        lualine_a = { edge_component(cwd) },
        lualine_b = { tabs },
        lualine_c = { filename },
        lualine_x = {
          orgmode_status,
          lsp,
          diagnostics,
        },
        lualine_y = {
          diff,
          branch,
        },
        lualine_z = {
          selectioncount,
          macro,
          location,
          edge_component(progress, "right"),
        },
      },
    })
  end,
}
local incline = {
  src = "b0o/incline.nvim",
  config = function()
    vim.o.laststatus = 3
    local icons = require("icons")
    local preset_statusline = config.preset_statusline
    local preset = config.preset_incline or preset_statusline
    local wrap_char = ({
      bubble = {
        left = icons.sep("round_left_filled"),
        right = icons.sep("round_right_filled"),
      },
      slanted = {
        left = icons.sep("slant_left_filled"),
        right = icons.sep("slant_right_filled"),
      },
      slanted2 = {
        left = icons.sep("slant_left_upper"),
        right = icons.sep("slant_right_upper"),
      },
      slanted3 = {
        left = icons.sep("slant_left_filled"),
        right = icons.sep("slant_right_upper"),
      },
      asymmetric = {
        left = icons.sep("round_left_filled"),
        right = icons.sep("slant_right_upper"),
      },
      asymmetric2 = {
        left = icons.sep("slant_left_upper"),
        right = icons.sep("round_right_filled"),
      },
    })[preset]

    if wrap_char == nil or preset == "simple" then
      wrap_char = { left = "", right = "" }
    end

    require("incline").setup({
      window = {
        padding = 0,
        margin = { vertical = 0 },
        overlap = { borders = true },
      },
      highlight = {
        groups = {
          InclineNormal = "StatusLine",
          InclineNormalNC = "StatusLineNC",
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

        if filename == "" then
          filename = "[No Name]"
        end

        local modified = vim.bo[props.buf].modified
        local modified_char = nil

        if modified then
          modified_char = icons.get("modified")
        end

        if not preset or preset == "simple" then
          return { { modified_char }, { " " .. filename .. " " } }
        end

        return {
          { wrap_char.left },
          { modified_char, gui = "reverse" },
          { " " .. filename .. " ", gui = "reverse" },
          { wrap_char.right },
        }
      end,
    })
  end,
}

local outline = {
  src = "hedyhli/outline.nvim",
  config = function()
    require("outline").setup({
      keymaps = {
        goto_location = "o",
        peek_location = "<S-Cr>",
        goto_and_close = "<Cr>",
      },
    })
    vim.keymap.set("n", "<leader>s", "<cmd>Outline<CR>", { silent = true, desc = "Toggle Outline" })
  end,
}
local neogit = {
  src = "NeogitOrg/neogit",
  config = function()
    local icons = require("icons")
    require("neogit").setup({
      graph_style = "unicode",
      disable_context_highlighting = true,
      signs = {
        -- { CLOSED, OPENED }
        hunk = { "", "" },
        item = { icons.get("fold_closed"), icons.get("fold_open") },
        section = { icons.get("fold_closed"), icons.get("fold_open") },
      },
    })
    vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>")
  end,
}
local diffview = {
  src = "dlyongemallo/diffview-plus.nvim",
  config = function()
    vim.o.fillchars = "diff: "

    local icons = require("icons")
    require("diffview").setup({
      use_icons = icons.enabled,
      file_panel = { listing_style = "list" },
    })
    vim.keymap.set("n", "<leader>gs", "<cmd>DiffviewOpen<cr>", { silent = true })
    vim.keymap.set("n", "<leader>gl", "<cmd>DiffviewFileHistory<cr>", { silent = true })
    vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { silent = true })
    vim.keymap.set("n", "<leader>g,", function()
      local prompt = "Search git: "
      local ok, query = pcall(vim.fn.input, prompt)
      if not ok or query == "" then
        return
      end
      vim.cmd("DiffviewFileHistory -S" .. query)
    end, { silent = true })
  end,
}
local oil = {
  src = "barrettruth/canola.nvim",
  config = function()
    require("oil").setup({
      columns = {
        "size",
      },
      view_options = { show_hidden = true },
      keymaps = {
        ["<localleader>tt"] = { "actions.open_terminal", mode = "n" },
        ["l"] = { "actions.select", mode = "n" },
        ["h"] = { "actions.parent", mode = "n" },
      },
    })
    vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { silent = true })
  end,
}
local gitsigns = {
  src = "lewis6991/gitsigns.nvim",
  config = function()
    local gs = require("gitsigns")
    gs.setup({
      on_attach = function(buffer)
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]g", function() gs.nav_hunk("next") end, "Next Hunk")
        map("n", "[g", function() gs.nav_hunk("prev") end, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, "Toggle Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, "Reset Hunk")
        map("n", "<leader>ghq", gs.setqflist, "Add hunks to qflist")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghX", gs.reset_buffer_index, "Unstage Buffer")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghP", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        map({ "n" }, "<leader>gb", gs.blame, "Blame")
        -- stylua: ignore end
      end,
      current_line_blame = true,
      current_line_blame_opts = { delay = 400 },
    })
  end,
}
local grug_far = {
  src = "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({
      icons = { enabled = false },
      transient = true,
      windowCreationCommand = "tab split",
      resultsSeparatorLineChar = "-",
      engines = {
        ripgrep = {
          extraArgs = "--smart-case --hidden --glob=!.git",
        },
      },
      openTargetWindow = {
        preferredLocation = vim.o.splitright and "right" or "left",
      },
    })
    vim.keymap.set("n", "<leader><c-f>", "<cmd>GrugFar<cr>", { silent = true })
    vim.keymap.set("x", "<leader><c-f>", "<cmd>GrugFar<cr>", { silent = true })
  end,
}
local blink_cmp = {
  src = "saghen/blink.cmp",
  version = vim.version.range("1.*"),
  config = function()
    require("blink.cmp").setup({
      signature = {
        enabled = true,
        window = { show_documentation = true },
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        menu = { draw = { columns = { { "label", "label_description", gap = 1 }, { "kind" } } } },
        documentation = { auto_show = true },
      },
      keymap = {
        -- same as ctrl+/
        ["<C-_>"] = { "show" },
      },
      cmdline = { enabled = false },
    })
  end,
}
local blink_indent = {
  src = "saghen/blink.indent",
  config = function()
    require("blink.indent").setup({
      static = {
        char = "┊",
      },
      scope = {
        char = "│",
        highlights = {
          "BlinkIndentScope",
        },
      },
    })
  end,
}
local conform = {
  src = "stevearc/conform.nvim",
  dependencies = { { src = "mason-org/mason.nvim" } },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        swift = { "swiftformat" },
        go = { "gofmt" },
        lua = { "stylua" },
        php = { "php_cs_fixer" },
        blade = { "blade-formatter" },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        haskell = { "fourmolu" },
      },
    })
    vim.keymap.set("n", "<leader>F", function()
      require("conform").format({ async = true })
    end)
  end,
}
local orgmode = {
  src = "nvim-orgmode/orgmode",
  config = function()
    require("orgmode").setup({
      mappings = { org = { org_toggle_checkbox = "<leader>o<tab>" } },
      win_split_mode = "tabnew",
      org_default_notes_file = "~/org/inbox.org",
      org_todo_keywords = { "TODO", "STARTED", "|", "DONE", "INVALID" },
      org_log_done = false,
      org_agenda_span = "month",
      org_agenda_files = { "~/org/**/*.org", "~/vault-org/**/*.org" },
      org_agenda_time_grid = {
        times = { 200, 400, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000, 2200, 2400 },
      },
      org_agenda_custom_commands = {
        l = {
          description = "All Items",
          types = {
            {
              type = "tags",
              org_agenda_overriding_header = "All Items",
            },
          },
        },
        p = {
          description = "Projects Agenda",
          types = {
            {
              type = "agenda",
              org_agenda_overriding_header = "Projects Agenda",
              org_agenda_files = { "~/vault-org/projects/**/*.org" },
            },
            {
              type = "tags_todo",
              org_agenda_overriding_header = "Project TODO",
              org_agenda_files = { "~/vault-org/projects/**/*.org" },
            },
          },
        },
        d = {
          description = "Projects DONE",
          types = {
            {
              type = "tags",
              match = 'TODO="DONE"',
              org_agenda_overriding_header = "Project DONE",
              org_agenda_files = { "~/vault-org/projects/**/*.org" },
            },
          },
        },
      },
    })
    vim.keymap.set("n", "<leader>oc", "<cmd>Org capture<cr>", { silent = true })
    vim.keymap.set("n", "<leader>oa", "<cmd>Org agenda<cr>", { silent = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      pattern = "orgagenda",
      callback = function()
        vim.cmd("setl cursorline")
      end,
    })
  end,
}
local opencode = {
  src = "pirey/opencode.nvim",
  dependencies = {
    { src = "saghen/blink.cmp", version = vim.version.range("1.*") },
    {
      src = "MeanderingProgrammer/render-markdown.nvim",
      config = function()
        require("render-markdown").setup({
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
          heading = { enabled = false },
          paragraph = { enabled = false },
        })
      end,
    },
  },
  config = function()
    require("opencode").setup({
      preferred_picker = 'select',
      keymap_prefix = "<leader>a",
      ui = {
        output = { auto_scroll = true },
        icons = { preset = config.use_nerd_font and "nerdfonts" or "text" },
      },
    })
  end,
}
local function setup(specs_ext)
  local specs = {}
  local configs = {}

  local function normalize_src(src)
    if src:match("^[a-z]+://") then
      return src
    end
    return "https://github.com/" .. src:gsub("^/", "")
  end

  -- resolve specs and configs
  for _, spec in ipairs(specs_ext) do
    if spec.dependencies then
      for _, dep in ipairs(spec.dependencies) do
        table.insert(specs, { src = normalize_src(dep.src), version = dep.version })
        if dep.config then
          table.insert(configs, dep.config)
        end
      end
    end
    table.insert(specs, vim.tbl_extend("force", spec, { src = normalize_src(spec.src) }))
    if spec.config then
      table.insert(configs, spec.config)
    end
  end

  -- install packages
  vim.pack.add(specs, { confirm = false })

  -- configure packages
  for _, config in ipairs(configs) do
    if type(config) == "function" then
      config()
    end
  end
end

setup({
  require("themes.onedark"),
  require("themes.nightfox"),
  require("themes.iceberg"),
  require("themes.tokyonight"),

  -- EDITING
  jump,
  surround,
  abolish,
  treesj,
  conform,
  blink_cmp,
  blink_indent,

  -- UI
  fff,
  satellite,
  illuminate,
  lualine,
  incline,
  outline,
  neogit,
  diffview,
  oil,
  gitsigns,
  grug_far,

  -- TOOLS
  mason,
  treesitter,
  lspconfig,

  orgmode,
  opencode,
})
