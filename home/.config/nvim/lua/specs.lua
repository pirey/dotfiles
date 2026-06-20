local augroup = vim.api.nvim_create_augroup("SpecsAugroup", { clear = true })

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
local diffview = {
  src = "dlyongemallo/diffview-plus.nvim",
  config = function()
    require("diffview").setup({
      use_icons = false,
      signs = { fold_closed = "❯", fold_open = "+" },
      file_panel = { listing_style = "list" },
    })
    vim.keymap.set("n", "<leader>gs", "<cmd>DiffviewOpen<cr>", { silent = true })
    vim.keymap.set("n", "<leader>gl", "<cmd>DiffviewFileHistory<cr>", { silent = true })
    vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { silent = true })
    vim.api.nvim_create_autocmd("User", {
      group = augroup,
      pattern = "DiffviewViewOpened",
      callback = function()
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype

          if ft ~= "DiffviewFileHistory" and ft ~= "DiffviewFiles" then
            vim.wo[win].wrap = true
          end
        end
      end,
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
        map("n", "]g", function() gs.nav_hunk("next", { target = "all" }) end, "Next Hunk")
        map("n", "[g", function() gs.nav_hunk("prev", { target = "all" }) end, "Prev Hunk")
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
  -- EDITING
  surround,
  abolish,
  treesj,
  conform,
  blink_cmp,

  -- UI
  diffview,
  oil,
  gitsigns,
  grug_far,

  -- TOOLS
  mason,
  treesitter,
  lspconfig,

  orgmode,
})
