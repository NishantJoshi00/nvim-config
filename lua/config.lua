-- Configure diagnostics to update in insert mode (Neovim 0.10+ API)
vim.diagnostic.config({
    update_in_insert = true,
    float = {
        border = "rounded",
        source = "if_many",
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

-- Highlight customization
vim.cmd([[highlight IndentBlanklineChar guifg=#202020 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineContextChar guifg=#505050 gui=nocombine]])
-- vim.cmd([[highlight Cursorline gui=underline cterm=underline guisp=gray guibg=NONE]])

vim.cmd([[autocmd BufRead,BufNewFile *.Jenkinsfile setfiletype groovy]])


vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- Enable inlay hints if supported
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, {
                bufnr = args.buf
            })
        end

        -- Enable semantic tokens if supported (Neovim 0.10+)
        if client.server_capabilities.semanticTokensProvider then
            vim.api.nvim_set_hl(0, "@lsp.type.comment", {})  -- Don't override treesitter for comments
        end
    end
})

-- LuaToBuffer: Execute Lua code and append output to current buffer
-- WARNING: This command executes arbitrary Lua code without sandboxing
-- It is intended for debugging/development purposes only
-- Do not use this command with untrusted input as it can execute any Lua code
vim.api.nvim_create_user_command('LuaToBuffer', function(opts)
    local output = vim.fn.execute('lua ' .. opts.args)
    vim.api.nvim_buf_set_lines(0, -1, -1, false, vim.split(output, '\n'))
end, { nargs = '+' })

vim.filetype.add({
    extension = {
        mlw = 'ocaml',
    }
})
