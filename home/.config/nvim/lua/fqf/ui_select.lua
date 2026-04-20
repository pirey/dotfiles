local View = require("fqf.view")

local function ui_select(items, opts, on_choice)
  opts = opts or {}

  local qf_items = {}
  local prompt = opts.prompt or "Select"
  local format_item = opts.format_item or tostring
  for _, item in ipairs(items) do
    qf_items[#qf_items + 1] = {
      text = format_item(item),
      user_data = item,
    }
  end

  local view = View:new(qf_items, {
    title = prompt,
    filter_by = "text",
    on_select = function(qf_item)
      local item = qf_item.user_data
      if not qf_item.user_data then
        return
      end
      on_choice(item)
    end,
  })
  view:open()
end

return ui_select
