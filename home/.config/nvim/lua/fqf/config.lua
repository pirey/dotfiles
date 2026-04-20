local M = {}

M.default = {
  prompt = {
    prefix = " ",
    keymaps = {
      ["close"] = { "<esc>", "<c-c>" },
      ["focus_list"] = { "<tab>" },
      ["open"] = { "<cr>" },
      ["open_vsplit"] = { "<c-v>" },
      ["open_split"] = { "<c-s>" },
      ["open_tab"] = { "<c-t>" },
      ["up"] = { "<c-p>" },
      ["down"] = { "<c-n>" },
      ["cancel"] = { "<c-q>" },
    },
  },
  list = {
    keymaps = {
      ["cancel"] = { "<c-q>" },
      ["close"] = { "<esc>", "<c-c>" },
      ["focus_prompt"] = { "<tab>" },
      ["open"] = { "<cr>" },
      ["open_vsplit"] = { "<c-v>" },
      ["open_split"] = { "<c-s>" },
      ["open_tab"] = { "<c-t>" },
      ["up"] = { "<c-p>" },
      ["down"] = { "<c-n>" },
    },
  },
  ui_select = {
    enabled = true,
  },
  formatter = {
    enabled = true,
  },
}

M.opts = {}

return M
