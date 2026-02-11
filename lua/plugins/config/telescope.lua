return function()
  require("telescope").setup({
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
      },
    },
  })

  pcall(require("telescope").load_extension, "fzf")
end
