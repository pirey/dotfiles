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
    list = {},
    prompt = {},
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
