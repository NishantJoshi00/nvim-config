return function()
  local gs = require("gitsigns")
  local keymap = vim.keymap.set

  keymap("n", "<leader>gb", gs.blame_line, { desc = "Git blame" })
  keymap("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset git hunk" })
  keymap("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage git hunk" })
  keymap("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
  keymap("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Staged Hunk" })
  keymap("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview current hunk" })
  keymap("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { desc = "Git blame with diff" })
  keymap("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle current git blame" })
  keymap("n", "<leader>ghd", gs.diffthis, { desc = "Git diff current line" })
  keymap("n", "<leader>ghD", function() gs.diffthis("~") end, { desc = "Git diff buffer" })
  keymap("n", "<leader>gtd", gs.toggle_deleted, { desc = "Show deleted or modified code" })
end
