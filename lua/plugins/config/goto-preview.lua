return function()
  require("goto-preview").setup({
    width = 120,
    height = 15,
    border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
    default_mappings = false,
    focus_on_open = true,
    dismiss_on_move = false,
    force_close = true,
    bufhidden = "wipe",
  })
end
