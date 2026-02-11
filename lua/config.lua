vim.diagnostic.config({
    update_in_insert = true,
    float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
    signs = true,
    underline = true,
    virtual_text = {
        spacing = 4,
        prefix = "●",
    },
    severity_sort = true,
})

vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#202020", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#505050", nocombine = true })

local function setup_float_highlights()
    local set_hl = vim.api.nvim_set_hl
    local links = {
        "NormalFloat", "FloatTitle", "OilFloat",
        "TelescopeNormal", "TelescopeBorder",
        "TelescopePromptNormal", "TelescopePromptBorder",
        "WhichKeyFloat", "Pmenu", "NormalNC", "FloatermNC",
    }
    for _, group in ipairs(links) do
        set_hl(0, group, { link = "Normal" })
    end
    set_hl(0, "FloatBorder", { fg = "#c5c9c5", bg = "NONE" })
    set_hl(0, "PmenuBorder", { fg = "#c5c9c5", bg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_float_highlights })
setup_float_highlights()

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.Jenkinsfile",
    callback = function() vim.bo.filetype = "groovy" end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end

        if client.server_capabilities.semanticTokensProvider then
            vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
        end
    end,
})

vim.api.nvim_create_user_command("LuaToBuffer", function(opts)
    local output = vim.fn.execute("lua " .. opts.args)
    vim.api.nvim_buf_set_lines(0, -1, -1, false, vim.split(output, "\n"))
end, { nargs = "+" })

vim.filetype.add({
    extension = {
        mlw = "ocaml",
    },
})
