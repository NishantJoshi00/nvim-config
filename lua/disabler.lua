local keybind_store = {}

local function enable_all_keybinds()
  for _, data in ipairs(keybind_store) do
    vim.keymap.set(data.mode, data.lhs, data.rhs or data.callback, data.extra)
  end
end

local function disable_all_keybinds()
  local keybinds = {}
  local modes = { "n", "v" }
  local registry_set = {}
  for _, mode in ipairs(modes) do
    registry_set[mode] = {}
    for _, data in ipairs(vim.api.nvim_get_keymap(mode)) do
      table.insert(keybinds, {
        mode = mode,
        lhs = data.lhs,
        rhs = data.rhs,
        extra = {
          noremap = data.noremap,
          nowait = data.nowait,
          silent = data.silent,
          script = data.script,
        },
        callback = data.callback,
      })

      if not registry_set[mode][data.lhs] then
        pcall(vim.keymap.del, mode, data.lhs)
        registry_set[mode][data.lhs] = true
      end
    end
  end

  keybind_store = keybinds
end

return {
  disable = disable_all_keybinds,
  enable = enable_all_keybinds,
}
