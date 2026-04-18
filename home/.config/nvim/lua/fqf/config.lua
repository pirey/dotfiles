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
    },
  },
  list = {
    keymaps = {
      ["focus_prompt"] = { "<tab>" },
      ["up"] = { "<c-p>" },
      ["down"] = { "<c-n>" },
    },
  },
  ui_select = {
    enabled = true,
  },
  qftf = {
    enabled = true,
  },
}

M.opts = {}

return M
