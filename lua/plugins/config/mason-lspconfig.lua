return function()
    -- Configure LSP borders
    local border = "rounded"

    -- Set floating window background color

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup({
        handlers = {
            -- Default handler for all servers
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            -- Skip rust_analyzer (managed by rustaceanvim)
            ["rust_analyzer"] = function() end,
            -- Skip hls (managed by haskell-tools.nvim)
            ["hls"] = function() end,
        }
    })
end
