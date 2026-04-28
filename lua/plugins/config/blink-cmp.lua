return function()
    local ok, blink = pcall(require, "blink.cmp")
    if not ok then
        vim.notify("Failed to load blink.cmp", vim.log.levels.ERROR)
        return
    end

    blink.setup({
        keymap = {
            preset = 'none',
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },
            ['<C-p>'] = { 'show', 'select_prev', 'fallback' },
            ['<C-n>'] = { 'show', 'select_next', 'fallback' },
            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
        },

        appearance = {
            nerd_font_variant = 'mono',
        },

        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
            menu = {
                border = 'rounded',
                winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
                draw = {
                    columns = {
                        { 'source_name' },
                        { 'label', 'label_description', gap = 1 },
                        { 'kind_icon', 'kind' },
                    },
                    components = {
                        source_name = {
                            text = function(ctx)
                                local aliases = {
                                    lsp = '[LSP]',
                                    buffer = '[Buffer]',
                                    path = '[Path]',
                                    snippets = '[Snippet]',
                                }
                                return aliases[ctx.source_id] or ('[' .. ctx.source_name .. ']')
                            end,
                            highlight = 'BlinkCmpSource',
                        },
                    },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = {
                    border = 'rounded',
                    winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,EndOfBuffer:NormalFloat',
                },
            },
        },

        signature = {
            enabled = true,
            window = {
                border = 'rounded',
                winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
            },
        },

        sources = {
            default = { 'lsp', 'snippets', 'buffer', 'path' },
        },

        cmdline = {
            keymap = {
                preset = 'inherit',
                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
            },
            completion = {
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },
                menu = {
                    auto_show = true,
                    draw = {
                        columns = {
                            { 'label', 'label_description', gap = 1 },
                            { 'kind_icon', 'kind' },
                        },
                    },
                },
            },
        },

        fuzzy = {
            implementation = 'prefer_rust_with_warning',
        },
    })
end
