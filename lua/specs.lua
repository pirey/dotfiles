local wakatime = { src = "wakatime/vim-wakatime" }
local surround = {
  src = "tpope/vim-surround",
  dependencies = { { src = "tpope/vim-repeat" } },
}
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
      file_panel = { listing_style = "list" },
      keymaps = {
        file_panel = {
          { "n", "cc", "<cmd>top Git commit<cr>", { desc = "Commit staged changes" } },
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
    vim.keymap.set("n", "<c-j>", "<cmd>TSJToggle<cr>", { silent = true, desc = "Join/split line" })
  end,
}
local nvim_ts_autotag = {
  src = "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
local treesitter = {
  src = "nvim-treesitter/nvim-treesitter",
  config = function()
    local ts = require("nvim-treesitter")
    local languages = {
      "haskell",
      "nix",
      "javascript",
      "typescript",
      "tsx",
      "lua",
      "html",
      "blade",
      "php",
      "diff",
    }
    local activate_on_ft = vim.list_extend({
      "typescriptreact",
      "javascriptreact",
      "markdown",
      "opencode_output",
      "c",
    }, languages)

    local installed = ts.get_installed()
    local task = ts.install(languages)

    task:await(function(err)
      if err then
        vim.notify("Treesitter install failed: " .. err, "error")
      else
        local installed_after = ts.get_installed()
        if #installed ~= #installed_after then
          vim.notify("Treesitter parsers installed!", "info")
        end
      end
    end)

    vim.api.nvim_create_autocmd("FileType", {
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

    vim.lsp.document_color.enable(true, {}, { style = "virtual" })

    vim.lsp.enable({
      "lua_ls",
      "phpactor",
      -- "clangd",
      "tailwindcss",
      "vtsls",
      "gopls",
      "rust_analyzer",
      "ols",
      "cssls",
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
local oil = {
  src = "stevearc/oil.nvim",
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
    vim.keymap.set("n", "-", "<cmd>Oil<cr>", { silent = true })
    vim.keymap.set("n", "<leader>e", "<cmd>Oil .<cr>", { silent = true })
  end,
}
local fzf_lua = {
  src = "ibhagwan/fzf-lua",
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      winopts = { backdrop = 100 },
      keymap = {
        builtin = {
          ["<c-d>"] = "preview-page-down",
          ["<c-u>"] = "preview-page-up",
        },
        fzf = {
          ["ctrl-d"] = "preview-page-down",
          ["ctrl-u"] = "preview-page-up",
        },
      },
    })
    fzf.register_ui_select()

    vim.keymap.set("n", "<leader>f", function()
      require("fzf-lua").combine({
        pickers = { "oldfiles", "files" },
        winopts = { title = " Files " },
        include_current_session = true,
        cwd_only = true,
      })
    end, { silent = true })
    vim.keymap.set("n", "<leader>.", "<cmd>FzfLua resume<cr>")
    vim.keymap.set("n", "<leader>k", "<cmd>FzfLua keymaps<cr>")
    vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<cr>")
    vim.keymap.set("n", "<leader>d", "<cmd>FzfLua lsp_document_diagnostics<cr>")
    vim.keymap.set("n", "<leader>s", "<cmd>FzfLua lsp_document_symbols<cr>")
    vim.keymap.set("n", "<leader>r", "<cmd>FzfLua lsp_references<cr>")
    vim.keymap.set("n", "<leader>h", "<cmd>FzfLua helptags<cr>")
    vim.keymap.set("n", "<leader>l", "<cmd>FzfLua highlights<cr>")
    vim.keymap.set("n", "<leader>,", "<cmd>FzfLua live_grep<cr>")
    vim.keymap.set("n", "<leader>/", "<cmd>FzfLua blines<cr>")
    vim.keymap.set("n", "<leader>'", "<cmd>FzfLua oldfiles include_current_session=true cwd_only=true<cr>")
    vim.keymap.set("n", "<leader>u", "<cmd>FzfLua undotree<cr>")
    vim.keymap.set("n", "<leader>j", "<cmd>FzfLua jumps<cr>")
    vim.keymap.set("n", "<leader><tab><tab>", "<cmd>FzfLua tabs show_unlisted=true<cr>")
    vim.keymap.set("n", "<leader><leader>f", "<cmd>FzfLua git_status<cr>")
    vim.keymap.set("n", "<leader><leader>d", function()
      fzf.fzf_exec("fd --type d", {
        prompt = "Directories ",
        actions = {
          ["default"] = function(selected)
            vim.cmd("edit " .. selected[1])
          end,
          ["ctrl-s"] = function(selected)
            vim.cmd("split " .. selected[1])
          end,
          ["ctrl-v"] = function(selected)
            vim.cmd("vsplit " .. selected[1])
          end,
          ["ctrl-t"] = function(selected)
            vim.cmd("tabedit " .. selected[1])
          end,
        },
      })
    end, { desc = "Find Directories" })

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "FloatBorder" })
      end,
    })
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
    { src = "ibhagwan/fzf-lua" },
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
  require("themes.nightfox"),
  require("themes.onedark"),
  require("themes.iceberg"),
  require("themes.vscode"),
  { src = "folke/tokyonight.nvim" },
  { src = "rose-pine/neovim", name = "rose-pine" },
  { src = "miikanissi/modus-themes.nvim" },
  { src = "vague-theme/vague.nvim" },
  { src = "catppuccin/nvim", name = "catppuccin" },
  { src = "rebelot/kanagawa.nvim" },

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
  oil,
  fzf_lua,
  -- mini_pick,
  gitsigns,
  grug_far,

  -- TOOLS
  mason,
  treesitter,
  nvim_ts_autotag,
  lspconfig,

  -- AI
  opencode,
  supermaven,

  -- ETC
  scratch,
  wakatime,
  orgmode,
  dadbod_ui,
  curl,
}
