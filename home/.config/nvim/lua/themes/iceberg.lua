return {
  src = "cocopon/iceberg.vim",
  config = function()
    local function patch_hl(hlg, patch)
      local hl = vim.api.nvim_get_hl(0, {
        name = hlg,
      })
      vim.api.nvim_set_hl(0, hlg, vim.tbl_deep_extend("keep", patch, hl))
    end

    local function patch_group_pattern(hlg_pattern, patch)
      for _, hlg in pairs(vim.fn.getcompletion(hlg_pattern, "highlight")) do
        patch_hl(hlg, patch)
      end
    end

    local custom_highlight = vim.api.nvim_create_augroup("CustomIceberg", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = custom_highlight,
      pattern = "iceberg",
      callback = function()
        local fg = "#c6c8d1"
        local bg = "#161821"
        local fg_dark = "#3e445e" -- from StatusLineNC
        local bg_dark = "#0f1117" -- from StatusLineNC
        local statusline_fg = fg
        local statusline_bg = bg_dark
        local comment_fg = "#6b7089"
        local border_fg = fg_dark
        local float_bg = bg
        local float_fg = fg
        local float_border = border_fg
        local linenr_fg = "#444b71"
        local linenr_bg = bg
        local visual = "#272c42"
        local diff_add = "#45493e"
        local diff_change = visual
        local diff_delete = "#53343b"
        local tabline_fg = statusline_fg
        local tabline_bg = statusline_bg
        local diff_text = "#384851"

        if vim.o.background == "light" then
          bg = "#e8e9ec"
          fg = "#33374c"
          fg_dark = "#cad0de"
          bg_dark = "#8b98b6"
          border_fg = fg_dark
          float_bg = bg
          float_fg = fg
          float_border = fg
          linenr_fg = "#9fa7bd"
          linenr_bg = bg
          diff_add = "#d4dbd1"
          diff_change = "#ced9e1"
          diff_delete = "#e3d2da"
          diff_text = "#acc5d3"
          tabline_fg = "#8b98b6"
          tabline_bg = "#cad0de"
          statusline_fg = fg
          statusline_bg = tabline_bg
        end

        vim.api.nvim_set_hl(0, "NonText", { link = "Comment" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = bg, bg = bg }) -- squiggly ~
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = border_fg, bold = true })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = linenr_bg })
        vim.api.nvim_set_hl(0, "FoldColumn", { bg = bg, fg = fg_dark })
        vim.api.nvim_set_hl(0, "StatusLine", { fg = statusline_fg, bg = statusline_bg })
        vim.api.nvim_set_hl(0, "StatusLineTerm", { fg = statusline_fg, bg = statusline_bg })
        vim.api.nvim_set_hl(0, "TabLineFill", { fg = tabline_fg, bg = tabline_bg })

        -- line number
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = bg, bold = true })
        vim.api.nvim_set_hl(0, "LineNr", { bg = linenr_bg, fg = linenr_fg })

        -- colored text in diff
        vim.api.nvim_set_hl(0, "DiffAdd", { bg = diff_add, fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffChange", { bg = diff_change, fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffDelete", { bg = diff_delete, fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffText", { bg = diff_text, fg = "NONE" })

        -- float
        vim.api.nvim_set_hl(0, "Pmenu", { bg = float_bg, fg = float_fg })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = float_bg, fg = float_fg })

        -- float border
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = float_bg, fg = float_border })
        vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { bg = float_bg, fg = float_border })
        vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = float_bg, fg = float_border })
        vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = float_bg, fg = float_border })
        vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = float_bg, fg = float_border })

        -- Italic jsx/html tag attribute @tag.attribute.tsx htmlArg
        vim.api.nvim_set_hl(0, "Constant", { fg = "#a093c7", italic = true })

        patch_group_pattern("GitGutter", { bg = linenr_bg })
        patch_group_pattern("Diagnostic", { bg = linenr_bg })

        -- etc
        vim.api.nvim_set_hl(0, "FzfLuaBufFlagCur", { link = "Title" })
        vim.api.nvim_set_hl(0, "FzfLuaHeaderText", { link = "Title" })
        vim.api.nvim_set_hl(0, "FzfLuaPathLineNr", { link = "Title" })
        vim.api.nvim_set_hl(0, "FzfLuaHeaderBind", { link = "Title" })
        vim.api.nvim_set_hl(0, "FzfLuaTabMarker", { link = "Title" })
        vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = border_fg })

        patch_group_pattern("DiagnosticUnderline", { undercurl = true })

        -- transparent
        -- vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "NONE", bg = "NONE" }) -- squiggly ~
        -- vim.api.nvim_set_hl(0, "Normal", { fg = "NONE", bg = "NONE" }) -- squiggly ~
        -- vim.api.nvim_set_hl(0, "SignColumn", { fg = "NONE", bg = "NONE" }) -- squiggly ~
        -- vim.api.nvim_set_hl(0, "FoldColumn", { fg = "NONE", bg = "NONE" }) -- squiggly ~
        -- patch_group_pattern("GitGutter", { bg = "NONE" })
        -- patch_group_pattern("Diagnostic", { bg = "NONE" })
      end,
    })

    -- vim.opt.background = "dark"
    -- vim.cmd.colorscheme("iceberg")
  end,
}
