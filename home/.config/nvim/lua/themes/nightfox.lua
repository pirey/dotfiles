return {
  src = "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup({
      -- reduce yellow color usage, make it more blue-ish
      groups = {
        nightfox = {
          ["DiffText"] = { bg = "#2f5f73" },
          ["diffAdded"] = { bg = "#26343c" },
          ["diffChanged"] = { bg = "#243244" },
          ["diffRemoved"] = { bg = "#2f2837" },
          ["diffFile"] = { fg = "palette.fg2", style = "standout,reverse" },
          ["@tag.builtin.tsx"] = { link = "Keyword" },
          ["@type.tsx"] = { link = "Keyword" },
          ["@type.javascript"] = { link = "Keyword" },
          ["@type.typescript"] = { link = "@type.builtin" },
          ["@type.php"] = { fg = "palette.cyan" },
          ["@module.php"] = { fg = "palette.yellow" },
          ["FlashLabel"] = { link = "IncSearch" },
        },
      },
    })
  end,
}
