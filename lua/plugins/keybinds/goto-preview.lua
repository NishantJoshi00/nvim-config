return function()
  local gp = require("goto-preview")
  local keymap = vim.keymap.set

  keymap("n", "gpd", gp.goto_preview_definition, { desc = "preview definition" })
  keymap("n", "gpt", gp.goto_preview_type_definition, { desc = "preview type definition" })
  keymap("n", "gpi", gp.goto_preview_implementation, { desc = "preview implementation" })
  keymap("n", "gP", gp.close_all_win, { desc = "close all previews" })
  keymap("n", "gpr", gp.goto_preview_references, { desc = "preview references" })
end
