return function()
  vim.keymap.set("n", "<leader>gb", function()
    vim.cmd([[Gitsigns blame_line]])
  end, { desc = "Git blame" })

  local gs = require("gitsigns")

  vim.keymap.set('n', '<leader>ghr', gs.reset_hunk, { desc = "Reset git hunk" })
  vim.keymap.set('n', '<leader>ghs', gs.stage_hunk, { desc = "Stage git hunk" })
  -- vim.keymap.set('v', '<leader>ghs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
  -- vim.keymap.set('v', '<leader>ghr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
  vim.keymap.set('n', '<leader>ghS', gs.stage_buffer, { desc = "Stage Buffer" })
  vim.keymap.set('n', '<leader>ghu', gs.undo_stage_hunk, { desc = "Undo Staged Hunk" })
  -- vim.keymap.set('n', '<leader>ghR', gs.reset_buffer)
  vim.keymap.set('n', '<leader>ghp', gs.preview_hunk, { desc = "Preview current hunk" })
  vim.keymap.set('n', '<leader>ghb', function() gs.blame_line { full = true } end, { desc = "Git blame with diff" })
  vim.keymap.set('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = "Toggle current git blame" })
  vim.keymap.set('n', '<leader>ghd', gs.diffthis, { desc = "Git diff current line" })
  vim.keymap.set('n', '<leader>ghD', function() gs.diffthis('~') end, { desc = "Git diff buffer" })
  vim.keymap.set('n', '<leader>gtd', gs.toggle_deleted, { desc = "Show deleted or modified code" })
end
