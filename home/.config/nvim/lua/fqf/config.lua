local M = {}

M.default = {
  prompt = " ",
  view = {
    list = {
      number = false,
      signcolumn = "yes",
    },
  },
  keymaps = {
    list = {
      ["focus_prompt"] = { "<tab>" },
    },
    prompt = {
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
  ui_select = {
    enabled = true,
  },
  qftf = {
    enabled = true,
    filename_width = nil,
  },
}

M.opts = {}

return M
