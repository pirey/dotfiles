return {
  src = "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup({
      -- reduce yellow color usage, make it more blue-ish
      groups = {
        all = {
          ["DiffText"] = { bg = "#2f5f73" },
          ["@tag.builtin.tsx"] = { link = "Keyword" },
          ["@type.tsx"] = { link = "Keyword" },
          ["@type.javascript"] = { link = "Keyword" },
          ["@type.typescript"] = { link = "@type.builtin" },
        },
      },
    })
  end,
}
