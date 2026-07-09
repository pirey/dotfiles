return {
  src = "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = "day", -- The theme is used when the background is set to light
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },

      on_highlights = function(highlights, colors)
        highlights.Folded = {
          -- fg = colors.fg_dark,
          fg = colors.fg_gutter,
          bg = colors.bg_dark,
        }

        -- treesitter
        highlights["@tag.tsx"] = {}
        highlights["@tag.javascript"] = {}
        highlights["@markup.raw.markdown_inline"] = { bg = colors.none, fg = colors.blue }
      end,
    })
  end,
}
