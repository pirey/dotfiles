local wakatime = { src = "wakatime/vim-wakatime" }
local surround = { src = "tpope/vim-surround", dependencies = { { src = "tpope/vim-repeat" } } }
local fugitive = {
  src = "tpope/vim-fugitive",
  config = function()
    vim.cmd([[
          cabbrev <expr> git getcmdtype() == ':' && getcmdline() =~# '^git' ? 'Git' : 'git'
        ]])
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "git",
      callback = function()
        vim.keymap.set("n", "gq", "<Cmd>bd<CR>", { buffer = true })
      end,
    })

    vim.keymap.set("n", "<leader>gg", "<cmd>tab Git<cr>", { silent = true })
    vim.keymap.set("n", "<leader>gv", "<cmd>vert Git<cr>", { silent = true })
    vim.keymap.set("n", "<leader>gl", "<cmd>tab Git log --no-merges<cr>", { silent = true })
  end,
}
local abolish = { src = "tpope/vim-abolish" }
local mason = {
  src = "mason-org/mason.nvim",
  config = function()
    -- stolen from folke's drawer
    require("mason").setup()
    local registry = require("mason-registry")

    local ensure_installed = {
      "mmdc",
      "stylua",
      "clangd",
      "lua-language-server",
      "prettier",
      "tailwindcss-language-server",
      "vtsls",
      "phpactor",
      "phpcs",
      "php-cs-fixer",
      "blade-formatter",
      "rust-analyzer",
      "ols",
    }

    registry.refresh(function()
      for _, tool in ipairs(ensure_installed) do
        local p = registry.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
local sidescroll = { src = "pirey/vim-sidescroll" }
local winpick = {
  src = "pirey/winpick.nvim",
  config = function()
    require("winpick").setup({
      border = "none",
      padding = { x = 3, y = 1 },
    })
    vim.keymap.set("n", "<c-w>p", require("winpick").pick, { desc = "Pick window" })
    vim.keymap.set("n", "<c-w><c-p>", require("winpick").pick, { desc = "Pick window" })
  end,
}
local winshift = {
  src = "sindrets/winshift.nvim",
  config = function()
    vim.keymap.set("n", "<c-w><c-m>", "<cmd>WinShift<cr>", { silent = true })
    vim.keymap.set("n", "<c-w>m", "<cmd>WinShift<cr>", { silent = true })
    vim.keymap.set("n", "<c-w>X", "<cmd>WinShift swap<cr>", { silent = true, desc = "Swap window" })
  end,
}
local diffview = {
  src = "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup({
      use_icons = false,
      default_args = {
        DiffviewFileHistory = { "--max-count=100" },
      },
      file_panel = { listing_style = "list", win_config = { position = "top", height = 16 } },
      file_history_panel = { win_config = { position = "top", height = 16 } },
      keymaps = {
        file_panel = {
          { "n", "cc", "<cmd>Git commit<cr>", { desc = "Commit staged changes" } },
          { "n", "gq", "<cmd>tabclose<cr>", { desc = "Close tab" } },
        },
        file_history_panel = {
          { "n", "gq", "<cmd>tabclose<cr>", { desc = "Close tab" } },
        },
      },
    })
    vim.keymap.set("n", "<leader>gs", "<cmd>DiffviewOpen<cr>", { silent = true })
    vim.keymap.set("n", "<leader>gy", "<cmd>DiffviewFileHistory<cr>", { silent = true })
    vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { silent = true })
    vim.keymap.set(
      "n",
      "<leader>gt",
      "<cmd>DiffviewFileHistory -g --range=stash<cr>",
      { silent = true, desc = "Git latest stash" }
    )
  end,
}
local treesj = {
  src = "Wansmer/treesj",
  config = function()
    require("treesj").setup({ use_default_keymaps = false })
    vim.keymap.set("n", "<leader>j", "<cmd>TSJToggle<cr>", { silent = true, desc = "Join/split line" })
  end,
}
local treesitter = {
  src = "nvim-treesitter/nvim-treesitter",
  version = "master",
  -- build = ":TSUpdate", -- TODO: run :TSUpdate whenever pack updated/installed
  config = function()
    require("nvim-treesitter.configs").setup({
      modules = {},
      sync_install = false,
      ignore_install = {},
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "haskell",
        "nix",
        "javascript",
        "typescript",
        "tsx",
        "lua",
        "html",
        "blade",
        "php",
      },
    })
  end,
}
local lspconfig = {
  src = "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
        },
      },
    })

    vim.lsp.config("phpactor", {
      init_options = {
        ["language_server.diagnostic_ignore_codes"] = {
          "worse.docblock_missing_return_type",
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
          classFunctions = { "tw", "clsx", "tw\\.[a-z-]+", "twMerge" },
        },
      },
    })

    vim.lsp.enable({
      "lua_ls",
      "phpactor",
      -- "clangd",
      "tailwindcss",
      "vtsls",
      "gopls",
      "rust_analyzer",
      "ols",
      -- "hls",
    })

    vim.keymap.set("n", "<leader>ql", vim.diagnostic.setloclist, { desc = "Open local diagnostics" })
    vim.keymap.set("n", "<leader>qq", vim.diagnostic.setqflist, { desc = "Open global quickfix diagnostics" })

    -- disable semantic highlight
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.semanticTokensProvider then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end,
    })
  end,
}
local outline = {
  src = "hedyhli/outline.nvim",
  config = function()
    require("outline").setup()
    vim.keymap.set("n", "<leader>O", "<cmd>Outline<CR>", { silent = true, desc = "Toggle Outline" })
  end,
}
local mini_files = {
  src = "nvim-mini/mini.files",
  config = function()
    local mf = require("mini.files")
    mf.setup({
      content = { prefix = function() end },
      options = { use_as_default_explorer = true },
    })

    vim.keymap.set("n", "<leader>E", function()
      if not mf.close() then
        mf.open(vim.fn.getcwd())
      end
    end, { silent = true, desc = "Open file browser" })

    vim.keymap.set("n", "<leader>e", function()
      if not mf.close() then
        mf.open(vim.fn.expand("%:p:h"))
        mf.reveal_cwd()
      end
    end, { silent = true, desc = "Open file browser (buffer dir)" })

    -- Terminal keymaps via autocmd for mini.files buffers
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id

        local function open_terminal(key, cmd, desc)
          vim.keymap.set("n", key, function()
            local path = mf.get_fs_entry().path
            local dir = vim.fn.isdirectory(path) == 1 and path or vim.fn.fnamemodify(path, ":h")
            mf.close()
            vim.schedule(function()
              vim.cmd(cmd .. " | lcd " .. dir .. " | term")
            end)
          end, { buffer = buf_id, desc = desc })
        end

        open_terminal("<localleader>tv", "rightbelow vnew", "Open terminal (vertical)")
        open_terminal("<localleader>ts", "rightbelow new", "Open terminal (horizontal)")
        open_terminal("<localleader>tt", "tabnew", "Open terminal (tab)")
      end,
    })
  end,
}
local mini_pick = {
  src = "nvim-mini/mini.pick",
  dependencies = {
    { src = "nvim-mini/mini.extra" },
    { src = "nvim-mini/mini.visits" },
    { src = "pirey/mini.omnipick" },
  },
  config = function()
    local pick = require("mini.pick")
    local extra = require("mini.extra")
    local visits = require("mini.visits")
    local omnipick = require("mini.omnipick")

    pick.setup({
      source = { show = pick.default_show },
      mappings = {
        scroll_left = "<BS>",
        delete_char = "<c-h>",
      },
    })

    visits.setup()
    extra.setup()
    omnipick.setup({ show_icons = false })

    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(items, opts, on_choice)
      local cursor_anchor = vim.fn.screenrow() < 0.5 * vim.o.lines and "NW" or "SW"
      return pick.ui_select(items, opts, on_choice, {
        options = { content_from_bottom = cursor_anchor == "SW" },
        window = {
          config = {
            relative = "cursor",
            anchor = cursor_anchor,
            row = cursor_anchor == "NW" and 1 or 0,
            col = 0,
            width = math.min(60, math.floor(0.618 * vim.o.columns)),
            height = math.min(math.max(#items, 1), math.floor(0.45 * vim.o.columns)),
          },
        },
      })
    end

    vim.keymap.set("n", "<leader>k", "<cmd>Pick keymaps<cr>", { silent = true })
    vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<cr>", { silent = true })
    vim.keymap.set("n", "<leader>.", "<cmd>Pick resume<cr>", { silent = true })
    vim.keymap.set("n", "<leader>d", "<cmd>Pick diagnostic scope='current'<cr>", { silent = true })
    vim.keymap.set("n", "<leader>s", "<cmd>Pick lsp scope='document_symbol'<cr>", { silent = true })
    vim.keymap.set("n", "<leader>r", "<cmd>Pick lsp scope='references'<cr>", { silent = true })
    vim.keymap.set("n", "<leader>h", "<cmd>Pick help<cr>", { silent = true })
    vim.keymap.set("n", "<leader>l", "<cmd>Pick hl_groups<cr>", { silent = true })
    vim.keymap.set("n", "<leader>,", "<cmd>Pick grep_live<cr>", { silent = true })
    vim.keymap.set("n", "<leader>/", "<cmd>Pick buf_lines scope='current'<cr>", { silent = true })
    vim.keymap.set("n", "<leader>?", "<cmd>Pick buf_lines<cr>", { silent = true })
    vim.keymap.set("n", '<leader>"', "<cmd>Pick visit_paths<cr>", { silent = true })
    vim.keymap.set("n", "<leader>'", "<cmd>Pick oldfiles current_dir=true<cr>", { silent = true })
    vim.keymap.set("n", "<leader>f", "<cmd>Pick omni<cr>", { silent = true })
    vim.keymap.set("n", "<leader><leader>d", function()
      require("mini.pick").builtin.cli({
        command = { "fd", "--hidden", "-E", ".git", "--type", "d" },
      }, {
        source = { name = "Dir" },
      })
    end, { desc = "Find dir" })
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

        map("n", "]g", function()
          ---@diagnostic disable-next-line: param-type-mismatch
          gs.nav_hunk("next")
        end, "Next Hunk")
        map("n", "[g", function()
          ---@diagnostic disable-next-line: param-type-mismatch
          gs.nav_hunk("prev")
        end, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, "Toggle Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghP", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function()
          ---@diagnostic disable-next-line: param-type-mismatch
          gs.diffthis("~")
        end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        map({ "n" }, "<leader>gb", function()
          local tabpage = vim.api.nvim_get_current_tabpage()
          local wins = vim.api.nvim_tabpage_list_wins(tabpage)
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == "gitsigns-blame" then
              vim.api.nvim_set_current_win(win)
              return
            end
          end
          gs.blame()
        end, "GitSigns Blame")
      end,
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
      engines = {
        ripgrep = {
          extraArgs = "--smart-case --hidden --glob=!.git",
        },
      },
      openTargetWindow = {
        preferredLocation = vim.opt.splitright and "right" or "left",
      },
    })
    vim.keymap.set("n", "<leader><c-f>", "<cmd>GrugFar<cr>", { silent = true })
    vim.keymap.set("x", "<leader><c-f>", "<cmd>GrugFar<cr>", { silent = true })
  end,
}
local blink_cmp = {
  src = "saghen/blink.cmp",
  dependencies = { { src = "rafamadriz/friendly-snippets" } },
  version = "v1.9.1",
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
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind" } },
          },
        },
        documentation = {
          auto_show = true,
        },
      },
      keymap = {
        -- same as ctrl+/
        ["<C-_>"] = { "show" },
      },
      cmdline = { enabled = false },
      sources = {
        per_filetype = {
          org = { "orgmode", "snippets" },
          sql = { "dadbod", "snippets" },
        },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          orgmode = { name = "Orgmode", module = "orgmode.org.autocompletion.blink", fallbacks = { "buffer" } },
        },
      },
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
        lua = { "stylua" },
        php = { "php_cs_fixer" },
        blade = { "blade-formatter" },
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
local nvim_lint = {
  src = "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = vim.tbl_extend("force", lint.linters_by_ft, {
      typescriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      php = { "phpcs" },
    })
    vim.keymap.set("n", "<leader>L", function()
      require("lint").try_lint()
    end)
  end,
}
local colorizer = {
  src = "catgoose/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup()
  end,
}
local dadbod_ui = {
  src = "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { src = "tpope/vim-dadbod" },
    { src = "kristijanhusak/vim-dadbod-completion" },
  },
  config = function()
    vim.g.db_ui_execute_on_save = 0
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql", "mysql", "plsql" },
      callback = function()
        vim.keymap.set("n", "<leader>s", "<Plug>(DBUI_ExecuteQuery)<Cmd>write<CR>", { silent = true })
      end,
    })
  end,
}
local curl = {
  src = "oysandvik94/curl.nvim",
  dependencies = { { src = "nvim-lua/plenary.nvim" } },
  config = function()
    require("curl").setup()
  end,
}
local orgmode = {
  src = "nvim-orgmode/orgmode",
  config = function()
    require("orgmode").setup({
      org_use_property_inheritance = false,
      hyperlinks = { sources = {} },
      mappings = {
        org = {
          org_toggle_checkbox = "<leader>o<tab>", -- <c-space> is reserved for tmux prefix
        },
      },
      win_split_mode = "vertical",
      org_agenda_files = { "~/org/**/*", "~/vault-org/**/*" },
      org_default_notes_file = "~/org/tasks.org",
      org_todo_keywords = { "TODO", "STARTED", "|", "DONE" },
      org_adapt_indentation = false,
      org_deadline_warning_days = 3,
      org_capture_templates = {
        n = {
          description = "Note",
          template = "* %?\n  %u",
          target = "~/org/dropnotes.org",
        },
      },
      org_agenda_custom_commands = {
        p = {
          description = "Projects Agenda",
          types = {
            {
              type = "agenda",
              org_agenda_overriding_header = "Projects Agenda",
              org_agenda_files = { "~/vault-org/projects/**/*" }, -- Can define files outside of the default org_agenda_files
            },
            {
              type = "tags_todo",
              org_agenda_overriding_header = "Project TODO",
              org_agenda_files = { "~/vault-org/projects/**/*" },
              -- org_agenda_tag_filter_preset = 'NOTES-REFACTOR' -- Show only headlines with NOTES tag that does not have a REFACTOR tag. Same value providad as when pressing `/` in the Agenda view
            },
          },
        },
      },
    })
    vim.keymap.set("n", "<leader>oc", "<cmd>Org capture<cr>", { silent = true })
    vim.keymap.set("n", "<leader>oa", "<cmd>Org agenda<cr>", { silent = true })
  end,
}
local opencode = {
  src = "sudo-tee/opencode.nvim",
  dependencies = {
    { src = "nvim-lua/plenary.nvim" },
    { src = "saghen/blink.cmp", version = "v1.9.1" },
    { src = "nvim-mini/mini.pick" },
  },
  config = function()
    require("opencode").setup({
      keymap_prefix = "<leader>a",
      ui = {
        output = { auto_scroll = true },
        icons = { preset = "text" },
      },
    })
  end,
}
local supermaven = {
  src = "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({})
  end,
}
local scratch = {
  src = "pirey/scratch.nvim",
  config = function()
    require("scratch").setup()
    vim.keymap.set("n", "<leader><leader>s", function()
      require("scratch").toggle()
    end, { silent = true })
  end,
}

return {
  -- THEMES
  -- require("themes.onedark"),
  -- require("themes.iceberg"),
  -- require("themes.vscode"),
  -- { src = "folke/tokyonight.nvim" },
  -- { src = "rose-pine/neovim", name = "rose-pine" },
  -- { src = "miikanissi/modus-themes.nvim" },
  -- { src = "vague-theme/vague.nvim" },
  -- { src = "catppuccin/nvim", name = "catppuccin" },
  -- { src = "rebelot/kanagawa.nvim" },
  { src = "EdenEast/nightfox.nvim" },

  -- EDITING
  sidescroll,
  surround,
  fugitive,
  abolish,
  treesj,
  conform,
  nvim_lint,
  blink_cmp,
  blink_indent,

  -- UI
  winpick,
  winshift,
  diffview,
  outline,
  mini_files,
  mini_pick,
  gitsigns,
  grug_far,

  -- TOOLS
  mason,
  treesitter,
  lspconfig,

  -- AI
  opencode,
  supermaven,

  -- ETC
  scratch,
  wakatime,
  colorizer,
  orgmode,
  dadbod_ui,
  curl,
}
