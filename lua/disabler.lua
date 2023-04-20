-- Key Binding Disabler
--

local function write_to_file(filename, content)
  local file = io.open(filename, "w")
  file:write(content)
  file:close()
end

local enable_all_keybinds = function()
  for _, data in ipairs(vim.g.keybind_store) do
    -- print(vim.inspect(data))
    if data.rhs == nil then
      vim.keymap.set('n', data.lhs, data.callback, data.extra)
    else
      vim.api.nvim_set_keymap('n', data.lhs, data.rhs, data.extra)
    end
  end
end

local disable_all_keybinds = function()
  local keybinds = {}
  for _, data in ipairs(vim.api.nvim_get_keymap('n')) do
    local lhs = data.lhs;

    local keys = {
      lhs = data.lhs,
      rhs = data.rhs,
      extra = {
        noremap = data.noremap,
        nowait = data.nowait,
        silent = data.silent,
        script = data.script,
        -- expr = data.expr,
      },
      callback = data.callback
    }


    table.insert(keybinds, keys)
    vim.api.nvim_del_keymap('n', lhs)
  end

  vim.g.keybind_store = keybinds
  vim.api.nvim_set_keymap('n', '<leader>xxx', [[<cmd>lua require("masking").enable()<cr>]], {})
end




return {
  disable = disable_all_keybinds,
  enable = enable_all_keybinds,
  write_to_file = write_to_file
}
