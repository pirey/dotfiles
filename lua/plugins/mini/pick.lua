return {
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
      local cursor_anchor = "NW"
      -- local cursor_anchor = vim.fn.screenrow() < 0.5 * vim.o.lines and "NW" or "SW"
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

    vim.keymap.set("n", "<leader>.", "<cmd>Pick resume<cr>", { silent = true })
    vim.keymap.set("n", "<leader>k", "<cmd>Pick keymaps<cr>", { silent = true })
    vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<cr>", { silent = true })
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
