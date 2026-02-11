return function()
  require("dashboard").setup({
    theme = "hyper",
    config = {
      header = require("ascii").art.misc.hydra.hydra,
      shortcut = {
        { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
        { icon = " Find Files", icon_hl = "@variable", desc = "", group = "Label", action = "Telescope find_files", key = "f" },
        { desc = "Change Branch", group = "DiagnosticHint", action = "Telescope git_branches", key = "a" },
        { desc = "View Man Pages", group = "DiagnosticHint", action = "Telescope man_pages", key = "m" },
      },
      project = { enable = false },
      packages = { enable = true },
      mru = { enable = false },
      footer = { "", require("functions").dashboard_footer() },
    },
  })
end
