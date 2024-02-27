local rust_analyzer_config = function()
  return {
    server = {
      settings = {
        ["rust_analyzer"] = {
          inlayHints = {
            lifetimeElisionHints = {
              useParameterNames = true,
              enable = "always",
            },
            expressionAdjustmentHints = {
              enable = "reborrow",
            },
            closureReturnTypeHints = {
              enable = "with_block",
            },
          },
          cargo = {
            buildScripts = {
              overrideCommand = nil,
            },
          },
          imports = {
            prefix = "crate",
          },
          diagnostics = {
            disabled = {
              "unresolved-macro-call",
            },
          },
          completion = {
            autoimport = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
            attributes = {
              enable = true,
            },
          },
        },
      },
    },
  }
end


return {
  ["rust-analyzer"] = rust_analyzer_config(),
}
