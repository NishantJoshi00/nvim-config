return function()
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    vim.notify("Failed to load telescope", vim.log.levels.ERROR)
    return
  end

  telescope.setup({

    defaults = {
      -- file_sorter = require("telescope.sorters").get_substr_matcher,
    },

    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
      }
    }
  })

  -- Load FZF extension
  pcall(telescope.load_extension, "fzf")
end
