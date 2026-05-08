return {
  src = "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup({
      -- reduce yellow color usage, make it more blue-ish
      groups = {
        nightfox = {
          ["@tag.builtin.tsx"] = { link = "Keyword" },
          ["@type.tsx"] = { link = "Keyword" },
          ["@type.javascript"] = { link = "Keyword" },
          ["@type.typescript"] = { link = "@type.builtin" },
          ["@type.php"] = { fg = "palette.cyan" },
          ["@module.php"] = { fg = "palette.yellow" },
          ["IncSearch"] = { bg = "palette.yellow", fg = "palette.black" },
        },
      },
    })
  end,
}
