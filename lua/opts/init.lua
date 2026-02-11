return {
  ["rust-analyzer"] = {
    tools = {
      autoSetHints = true,
      executor = require("rustaceanvim/executors").termopen,
      inlay_hints = {
        only_current_line = false,
        only_current_line_autocmd = "CursorHold",
        show_parameter_hints = false,
        show_variable_name = false,
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = true,
        right_align_padding = 7,
        highlight = "Comment",
      },
      hover_actions = {
        border = {
          { "╭", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╮", "FloatBorder" },
          { "│", "FloatBorder" },
          { "╯", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╰", "FloatBorder" },
          { "│", "FloatBorder" },
        },
        auto_focus = false,
      },
      crate_graph = {
        backend = "x11",
        full = true,
      },
    },
    server = {
      standalone = true,
      settings = {
        ["rust-analyzer"] = {
          imports = {
            enforce = true,
            prefix = "self",
            granularity = { group = "module" },
            importPrefix = "self",
            prefer = { no = { std = true } },
          },
          inlayHints = {
            only_current_line = false,
            only_current_line_autocmd = "CursorHold",
            show_parameter_hints = true,
            show_variable_name = false,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          cargo = { loadOutDirsFromCheck = true },
          procMacro = { enable = true },
          diagnostics = {
            enable = true,
            disabled = { "unresolved-proc-macro" },
            enableExperimental = true,
          },
          completion = {
            autoimport = { enable = true },
          },
          checkOnSave = {
            command = "clippy",
            allTargets = true,
          },
        },
      },
      on_attach = function(_client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end,
    },
  },
}
