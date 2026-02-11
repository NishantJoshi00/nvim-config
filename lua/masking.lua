local function get_listed_buffers()
  local buffers = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr)
        and vim.api.nvim_buf_is_valid(bufnr)
        and vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
    then
      buffers[#buffers + 1] = bufnr
    end
  end
  return buffers
end

local function set_buffer_opts(buffers, modifiable, readonly)
  for _, bufnr in ipairs(buffers) do
    vim.api.nvim_set_option_value("modifiable", modifiable, { buf = bufnr })
    vim.api.nvim_set_option_value("readonly", readonly, { buf = bufnr })
  end
end

local function mark_mutable()
  require("disabler").enable()
  for _, mode in ipairs({ "n", "v", "i" }) do
    vim.keymap.set(mode, ":", ":", { noremap = true })
  end
  vim.o.cmdheight = 1
  set_buffer_opts(get_listed_buffers(), true, false)
end

local function mark_immutable()
  require("disabler").disable()
  for _, mode in ipairs({ "n", "v", "i" }) do
    vim.keymap.set(mode, ":", "<Nop>", { noremap = true })
  end
  vim.o.cmdheight = 0
  set_buffer_opts(get_listed_buffers(), false, true)
end

vim.keymap.set("n", "<leader><c-d>", mark_immutable, { desc = "Disable all editing" })
vim.keymap.set("n", "<leader><c-a>", mark_mutable, { desc = "Enable all editing" })

return {
  mutable = mark_mutable,
  immutable = mark_immutable,
}
