---@class SpecExt : vim.pack.Spec
---@field config function
---@field dependencies vim.pack.Spec[]

---@param src string
---@return string
local function normalize_src(src)
  if src:match("^[a-z]+://") then
    return src
  end
  return "https://github.com/" .. src:gsub("^/", "")
end

local M = {}

local installed_specs do
  local cache = {}
  function installed_specs(is_active)
    local key = is_active == nil and "all" or tostring(is_active)
    if not cache[key] then
      local packspecs = vim.iter(vim.pack.get())
      if is_active ~= nil then
        packspecs = packspecs:filter(function(x)
          return x.active == is_active
        end)
      end
      cache[key] = packspecs
        :map(function(x)
          return x.spec.name
        end)
        :totable()
    end
    return cache[key]
  end
end

function M.list(opts)
  local specs = installed_specs()

  local update_opts = {}
  if opts and opts.offline then
    update_opts.offline = true
  end

  vim.pack.update(specs, update_opts)
end

function M.update(packages)
  local specs
  if packages and #packages > 0 then
    specs = packages
  else
    specs = installed_specs(true)
  end
  vim.pack.update(specs, { force = true })
end

function M.clean()
  local specs = installed_specs(false)
  vim.pack.del(specs, { force = true })
end

---@param specs_ext SpecExt[]
function M.setup(specs_ext)
  local specs = {}
  local configs = {}

  -- resolve specs and configs
  for _, spec in ipairs(specs_ext) do
    if spec.dependencies then
      for _, dep in ipairs(spec.dependencies) do
        table.insert(specs, { src = normalize_src(dep.src), version = dep.version })
      end
    end
    table.insert(specs, vim.tbl_extend("force", spec, { src = normalize_src(spec.src) }))
    if spec.config then
      table.insert(configs, spec.config)
    end
  end

  -- install packages
  vim.pack.add(specs)

  -- configure packages
  for _, config in ipairs(configs) do
    config()
  end

  -- create user commands
  vim.api.nvim_create_user_command("PackUpdate", function(opts)
    M.update(opts.fargs)
  end, {
    desc = "Update packages",
    nargs = "*",
    complete = function(_, opts)
      local all_specs = installed_specs(true)
      local selected = vim.list_slice(vim.split(opts, " "), 2)
      return vim.tbl_filter(function(spec)
        return not vim.tbl_contains(selected, spec)
      end, all_specs)
    end,
  })
  vim.api.nvim_create_user_command("PackClean", M.clean, { desc = "Clean all packages" })
  vim.api.nvim_create_user_command("PackList", function(opts)
    M.list({ offline = vim.tbl_contains(opts.fargs, "offline") })
  end, {
    desc = "List all packages",
    nargs = "*",
    complete = function()
      return { "offline" }
    end,
  })
end

return M
