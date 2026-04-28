local augroup = vim.api.nvim_create_augroup("SpecsAugroup", { clear = true })

local jump = {
  src = "yorickpeterse/nvim-jump",
  config = function()
    vim.keymap.set({ "n", "x" }, "s", function()
      require("jump").start()
    end)
  end,
}
local fqf = {
  src = "pirey/fqf.nvim",
  config = function()
    local fqf = require("fqf")
    fqf.setup()
    vim.keymap.set("n", "<leader>f", fqf.builtins.files)
    vim.keymap.set("n", "<leader>p", fqf.builtins.smart_files)
    vim.keymap.set("n", "<leader>,", fqf.builtins.live_grep)
    vim.keymap.set("n", "<leader><leader>,", fqf.builtins.grep)
    vim.keymap.set("n", "<leader><leader>d", fqf.builtins.dirs)
    vim.keymap.set("n", "<leader>'", fqf.builtins.oldfiles)
    vim.keymap.set("n", "<leader>gq", fqf.builtins.git_changes)
    vim.keymap.set("n", "<leader>/", fqf.builtins.buffer_lines)
  end,
}
local fugitive = {
  src = "tpope/vim-fugitive",
  config = function()
    vim.cmd([[
      cabbrev <expr> git getcmdtype() == ':' && getcmdline() =~# '^git' ? 'Git' : 'git'
    ]])

    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      pattern = { "git", "fugitive", "fugitiveblame" },
      callback = function(ev)
        for _, key in ipairs({ "q", "gq", "x", "<c-c>" }) do
          vim.keymap.set("n", key, "<cmd>bd<cr>", { buffer = true })
        end
        vim.keymap.set("n", "<c-n>", ")", { remap = true, buffer = true })
        vim.keymap.set("n", "<c-p>", "(", { remap = true, buffer = true })
        vim.keymap.set("n", "o", "gO", {
          buffer = true,
          remap = true,
          silent = true,
          desc = "vert split",
        })

        if ev.match == "git" then
          vim.wo.foldmethod = "syntax"
          vim.wo.foldlevel = 0
        end

        if ev.match == "fugitive" then
          vim.keymap.set("n", "<tab>", "=", { remap = true, buffer = true })
        end

        local winid = vim.api.nvim_get_current_win()
        vim.wo[winid][0].number = false
        vim.wo[winid][0].cursorline = true
        vim.wo[winid][0].cursorlineopt = "both"
      end,
    })

    local last_pos = { 1, 0 }
    vim.keymap.set("n", "<leader>gs", function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      for _, win in ipairs(wins) do
        local bufnr = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[bufnr].filetype
        if ft == "fugitive" then
          last_pos = vim.api.nvim_win_get_cursor(win)
          vim.api.nvim_win_close(win, true)
          return
        end
      end
      vim.cmd("Git")
      vim.api.nvim_win_set_cursor(vim.api.nvim_tabpage_get_win(0), last_pos)
    end, { silent = true })
    vim.keymap.set("n", "<leader>gg", "<cmd>tab Git<cr>", { silent = true })
    vim.keymap.set("n", "<leader>gv", "<cmd>vert Git<cr>", { silent = true })

    local log_count = 500
    local log_format = '--pretty=format:"%h │ %<(10,trunc)%an %>(12,trunc)%ar │ %s %d"'
    local log_str = "log " .. log_format .. " --no-merges --max-count=" .. log_count
    vim.keymap.set("n", "<leader>gf", "<cmd>tab Git log " .. log_format .. " -- %<cr>", { silent = true })
    vim.keymap.set("n", "<leader>gl", "<cmd>tab Git " .. log_str .. "<cr>", { silent = true })
    vim.keymap.set("n", "<leader>gn", function()
      local prev_pos = vim.fn.getpos(".")
      vim.cmd("normal! G0")
      local hash = vim.fn.expand("<cword>")
      vim.fn.setpos(".", prev_pos)
      if vim.fn.line("$") == log_count then
        vim.cmd("tab Git " .. log_str .. " " .. hash .. "^")
      end
    end, { silent = true })
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
    local languages = { "haskell", "nix", "javascript", "typescript", "tsx", "lua", "html", "blade", "php", "diff" }
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
          lint = {
            suggestCanonicalClasses = "ignore",
          },
          classFunctions = { "tw", "clsx", "tw\\.[a-z-]+", "twMerge" },
        },
      },
    })

    vim.lsp.document_color.enable(true, {}, { style = "virtual" })

    vim.lsp.enable({
      "lua_ls",
      "phpactor",
      "tailwindcss",
      "vtsls",
      "cssls",
      -- "gopls",
      -- "clangd",
      -- "rust_analyzer",
      -- "ols",
      -- "hls",
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
local outline = {
  src = "hedyhli/outline.nvim",
  config = function()
    require("outline").setup({
      symbols = {
        icon_fetcher = function()
          return ""
        end,
      },
    })
    vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", {
      silent = true,
      desc = "Toggle Outline",
    })
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
    vim.keymap.set("n", "-", "<cmd>Oil<cr>", { silent = true })
    vim.keymap.set("n", "<leader>e", "<cmd>Oil .<cr>", { silent = true })
  end,
}
local fff = {
  src = "https://github.com/dmtrKovalenko/fff.nvim",
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

    vim.g.fff = {
      prompt = " ",
      title = "Files",
      layout = {
        prompt_position = "top",
        flex = { wrap = "bottom" },
      },
      keymaps = {
        close = { "<esc>", "<c-c>" },
        cycle_grep_modes = "<c-_>",
        cycle_previous_query = "<c-k>",
      },
      icons = { enabled = false },
    }
    vim.keymap.set("n", "ff", function()
      require("fff").find_files()
    end)
    vim.keymap.set("n", "f,", function()
      require("fff").live_grep()
    end)
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
          gs.nav_hunk("next", {
            target = "all",
            count = 1,
            foldopen = true,
            greedy = true,
            navigation_message = true,
            wrap = vim.o.wrapscan,
            preview = true,
          })
        end, "Next Hunk")
        map("n", "[g", function()
          gs.nav_hunk("prev", {
            target = "all",
            count = 1,
            foldopen = true,
            greedy = true,
            navigation_message = true,
            wrap = vim.o.wrapscan,
            preview = true,
          })
        end, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, "Toggle Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, "Reset Hunk")
        map("n", "<leader>ghq", gs.setqflist, "Add hunks to qflist")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghX", gs.reset_buffer_index, "Unstage Buffer")
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
        preferredLocation = vim.o.splitright and "right" or "left",
      },
    })
    vim.keymap.set("n", "<leader><c-f>", "<cmd>GrugFar<cr>", { silent = true })
    vim.keymap.set("x", "<leader><c-f>", "<cmd>GrugFar<cr>", { silent = true })
  end,
}
local blink_cmp = {
  src = "saghen/blink.cmp",
  dependencies = { { src = "rafamadriz/friendly-snippets" } },
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
      org_todo_keywords = { "TODO", "STARTED", "|", "DONE", "INVALID" },
      org_agenda_span = "day",
      org_log_done = false,
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
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "orgagenda",
      callback = function()
        local win = vim.fn.win_getid()
        vim.wo[win].cursorline = true
        vim.wo[win].cursorlineopt = "both"
        vim.wo[win].signcolumn = "yes"
        vim.wo[win].number = false
      end,
    })
  end,
}

return {
  -- THEMES
  require("themes.nightfox"),

  -- EDITING
  -- jump,
  fugitive,
  surround,
  abolish,
  treesj,
  conform,
  blink_cmp,
  -- blink_indent,

  -- UI
  -- fqf,
  -- outline,
  oil,
  -- fff,
  gitsigns,
  grug_far,

  -- TOOLS
  mason,
  treesitter,
  lspconfig,

  orgmode,
}
