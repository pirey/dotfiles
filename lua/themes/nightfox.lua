return {
  src = "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup({
      groups = {
        all = {
          ["@tag.builtin.tsx"] = { link = "Keyword" },
          ["@type.tsx"] = { link = "Keyword" },
          ["@type.javascript"] = { link = "Keyword" },
        },
      },
    })
  end,
}
