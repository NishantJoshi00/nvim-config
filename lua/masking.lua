local get_listed_buffers = function()
  local buffers = vim.api.nvim_list_bufs()
  local output = {}
  for _, bufnr in ipairs(buffers) do
    if
        vim.api.nvim_buf_is_loaded(bufnr)
        and vim.api.nvim_buf_is_valid(bufnr)
        and vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
    then
      table.insert(output, bufnr)
    end
  end
  return output
end

local map_buffer = function(buffers, ops)
  for _, bufnr in ipairs(buffers) do
    ops(bufnr)
  end
end

local mark_buffer_modifiable = function(buffer)
  require("disabler").enable()
  vim.keymap.set("n", "<leader><c-d>", function() require("masking").immutable() end, {})

  map_buffer(buffer, function(bufnr)
    vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })
    vim.api.nvim_set_option_value("readonly", false, { buf = bufnr })
    vim.cmd([[nnoremap : :]])
    vim.cmd([[vnoremap : :]])
    vim.cmd([[inoremap : :]])
    vim.o.cmdheight = 1
  end)
end

local unmark_buffer_modifiable = function(buffer)
  require("disabler").disable()
  vim.keymap.set("n", "<leader><c-a>", function() require("masking").mutable() end, {})

  map_buffer(buffer, function(bufnr)
    vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
    vim.api.nvim_set_option_value("readonly", true, { buf = bufnr })
    vim.cmd([[nnoremap : <Nop>]])
    vim.cmd([[vnoremap : <Nop>]])
    vim.cmd([[inoremap : <Nop>]])
    vim.o.cmdheight = 0
  end)
end

local mark_listed_bufs_m = function()
  mark_buffer_modifiable(get_listed_buffers())
end

local unmark_listed_bufs_m = function()
  unmark_buffer_modifiable(get_listed_buffers())
end

vim.keymap.set("n", "<leader><c-d>", unmark_listed_bufs_m, {})
vim.keymap.set("n", "<leader><c-a>", mark_listed_bufs_m, {})

return {
  get_buffers = get_listed_buffers,
  mutable = mark_listed_bufs_m,
  immutable = unmark_listed_bufs_m,
}
