return function()
  vim.keymap.set("n", "gpd", function() require('goto-preview').goto_preview_definition() end,
    { desc = "preview definition" })
  vim.keymap.set("n", "gpt", function() require('goto-preview').goto_preview_type_definition() end,
    { desc = "preview type definition" })
  vim.keymap.set("n", "gpi", function() require('goto-preview').goto_preview_implementation() end,
    { desc = "preview implementation" })
  vim.keymap.set("n", "gP", function() require('goto-preview').close_all_win() end,
    { desc = "close all previews" })
  vim.keymap.set("n", "gpr", function() require('goto-preview').goto_preview_references() end,
    { desc = "preview references" })
end
