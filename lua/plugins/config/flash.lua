return {
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({
          search = {
            mode = function(str)
              return "\\<" .. str
            end,
          }
        })
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Flash Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
  opts = {
    modes = {
      char = {
        enabled = false
      }
    }
  }
}
