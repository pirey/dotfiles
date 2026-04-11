return {
  src = "navarasu/onedark.nvim",
  config = function()
    local onedark_group = vim.api.nvim_create_augroup("CustomOnedark", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = onedark_group,
      pattern = "onedark",
      callback = function()
        local c = require("onedark.colors")

        -- NOTE: MY PERSONAL PATCH FOR ONEDARK THEME
        -- REDUCE RED, YELLOW AND ORANGE TO MAKE IT MORE BLUE-ISH

        vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true })
        vim.api.nvim_set_hl(0, "QuickFixLine", { bg = c.bg1, underdashed = true })

        vim.api.nvim_set_hl(0, "Special", { fg = c.cyan })
        vim.api.nvim_set_hl(0, "@constant", { fg = c.fg, italic = true })
        vim.api.nvim_set_hl(0, "@constant.macro", { fg = c.fg, italic = true })
        vim.api.nvim_set_hl(0, "@constructor", { fg = c.fg })
        vim.api.nvim_set_hl(0, "@module", { fg = c.cyan })
        vim.api.nvim_set_hl(0, "@tag", { fg = c.cyan })
        vim.api.nvim_set_hl(0, "@tag.attribute", { fg = c.blue, italic = true })
        vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = c.fg })
        vim.api.nvim_set_hl(0, "Type", { fg = c.cyan })
        vim.api.nvim_set_hl(0, "@type", { fg = c.cyan })
        vim.api.nvim_set_hl(0, "@variable.builtin", { fg = c.cyan })
        vim.api.nvim_set_hl(0, "@variable.parameter", { fg = c.fg })
        vim.api.nvim_set_hl(0, "@type.builtin", { fg = c.blue })
        vim.api.nvim_set_hl(0, "@markup.heading", { fg = c.fg })
        vim.api.nvim_set_hl(0, "@org.checkbox", { link = "Comment" })
        vim.api.nvim_set_hl(0, "@org.checkbox.checked", { link = "String" })
        vim.api.nvim_set_hl(0, "@org.keyword.done", { fg = "#98c379", bold = true })

        local float_bg = c.bg
        local float_fg = c.fg
        local float_border = c.bg3

        -- float
        vim.api.nvim_set_hl(0, "Pmenu", { bg = float_bg, fg = float_fg })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = float_bg, fg = float_fg })

        -- float border
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = float_bg, fg = float_border })
        vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { bg = float_bg, fg = float_border })
        vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = float_bg, fg = float_border })
        vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = float_bg, fg = float_border })
        vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = float_bg, fg = float_border })
        vim.api.nvim_set_hl(0, "PmenuBorder", { bg = float_bg, fg = float_border })

        --
        vim.api.nvim_set_hl(0, "DiffAdded", { link = "DiffAdd" })
        vim.api.nvim_set_hl(0, "DiffRemoved", { link = "DiffDelete" })

        -- mini.nvim
        vim.api.nvim_set_hl(0, "MiniPickBorder", { bg = float_bg, fg = float_border })
        vim.api.nvim_set_hl(0, "MiniPickBorderBusy", { bg = float_bg, fg = float_border })
        vim.api.nvim_set_hl(0, "MiniPickBorderText", { bold = false })
        vim.api.nvim_set_hl(0, "MiniPickNormal", { bg = float_bg })
        vim.api.nvim_set_hl(0, "MiniFilesNormal", { bg = float_bg })
        vim.api.nvim_set_hl(0, "MiniFilesBorder", { bg = float_bg, fg = float_border })

        vim.api.nvim_set_hl(0, "FzfLuaBufFlagCur", { link = "Title" })
        vim.api.nvim_set_hl(0, "FzfLuaHeaderText", { link = "Title" })
        vim.api.nvim_set_hl(0, "FzfLuaPathLineNr", { link = "Title" })
        vim.api.nvim_set_hl(0, "FzfLuaHeaderBind", { link = "Title" })
        vim.api.nvim_set_hl(0, "FzfLuaTabMarker", { link = "Title" })
        vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = float_border })
        vim.api.nvim_set_hl(0, "FzfLuaFzfBorder", { fg = float_border })
        vim.api.nvim_set_hl(0, "FzfLuaFzfSeparator", { fg = "#444444" })

        vim.api.nvim_set_hl(0, "FoldColumn", { link = "Comment" })

        -- colorfix
        vim.api.nvim_set_hl(0, "@spell", {})
        vim.api.nvim_set_hl(0, "@nospell", {})
        vim.api.nvim_set_hl(0, "@org.agenda.scheduled", { fg = c.green })

        vim.api.nvim_set_hl(0, "BlinkIndent", { fg = "#383c44" })
        vim.api.nvim_set_hl(0, "BlinkIndentScope", { fg = "#454a56" })
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = onedark_group,
      pattern = "qf",
      callback = function()
        local winnr = vim.api.nvim_get_current_win()
        local ns_id = vim.api.nvim_create_namespace("qf_hl")

        vim.wo[winnr].cursorlineopt = "both"

        vim.api.nvim_win_set_hl_ns(winnr, ns_id)
        vim.api.nvim_set_hl(ns_id, "CursorLine", { underdotted = true })
      end,
    })
  end
}
