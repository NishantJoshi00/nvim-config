local unmanaged_handlers = function()
    -- Zig
    vim.g.zig_fmt_autosave = 0
    vim.g.zig_fmt_parse_errors = 0

    require("lspconfig").zls.setup({})
end



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

    require("mason-lspconfig").setup({})
    local capabilities = require("cmp_nvim_lsp").default_capabilities()


    unmanaged_handlers()
end
