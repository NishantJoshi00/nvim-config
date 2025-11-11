local custom = function()
    local gruvbox = function()

        local color = require("exports").colors

        return {
            inactive = {
                a = { fg = color.foreground, bg = color.shades[2], gui = "bold" },
                b = { fg = color.foreground, bg = color.shades[2] },
                c = { fg = color.foreground, bg = color.shades[1] },
            },
            visual = {
                a = { fg = color.shades[3], bg = color.ansi[6], gui = "bold" },
                b = { fg = color.foreground, bg = color.shades[2] },
                c = { fg = color.foreground, bg = color.shades[1] },
            },
            replace = {
                a = { fg = color.shades[3], bg = color.brights[4], gui = "bold" },
                b = { fg = color.foreground, bg = color.shades[2] },
                c = { fg = color.foreground, bg = color.shades[1] },
            },
            normal = {
                a = { fg = color.shades[3], bg = color.ansi[5], gui = "bold" },
                b = { fg = color.foreground, bg = color.shades[2] },
                c = { fg = color.foreground, bg = color.shades[1] },
            },
            insert = {
                a = { fg = color.shades[3], bg = color.ansi[2], gui = "bold" },
                b = { fg = color.foreground, bg = color.shades[2] },
                c = { fg = color.foreground, bg = color.shades[1] },
            },
            command = {
                a = { fg = color.shades[3], bg = color.ansi[4], gui = "bold" },
                b = { fg = color.foreground, bg = color.shades[2] },
                c = { fg = color.foreground, bg = color.shades[1] },
            },
        }
    end

    local symbols = {
        ["left"] = {
            left = "",
            right = "",
        },
        ["right"] = {
            left = "",
            right = "",
        },
        ["bubble"] = {
            left = "",
            right = "",
        },
        ["arrow"] = {
            left = "",
            right = "",
        },
        ["rect"] = {
            left = "▐",
            right = "▌",
        }
    }

    local current = symbols.left;

    local left = current.left;
    local right = current.right;



    local unix = '  ';
    local dos = '  ';
    local mac = '  ';



    -- Cache LSP info to avoid repeated lookups on every statusline refresh
    local lsp_info_cache = {}
    local function get_lsp_info()
        local bufnr = vim.api.nvim_get_current_buf()
        local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
        local cache_key = bufnr .. ":" .. buf_ft

        if lsp_info_cache[cache_key] then
            return lsp_info_cache[cache_key]
        end

        local msg = ""
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        if next(clients) == nil then
            lsp_info_cache[cache_key] = msg
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                lsp_info_cache[cache_key] = client.name
                return client.name
            end
        end
        lsp_info_cache[cache_key] = msg
        return msg
    end

    -- Invalidate cache on LSP attach/detach
    vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
        callback = function()
            lsp_info_cache = {}
        end,
    })

    local lsp_info = {
        get_lsp_info,
        color = { fg = '#2a2a2a', gui = 'bold' },
        separator = "",
    }

    local symbol_maker = function()
        if get_lsp_info() == "" then
            return "  "
        else
            return '  '
        end
    end

    local os_icon = function()
        local os = vim.uv.os_uname().sysname
        if os == 'Linux' then
            return unix
        elseif os == 'Darwin' then
            return mac
        elseif os == 'Windows' then
            return dos
        end
    end


    require('lualine').setup({
        extensions = { 'oil', 'fzf', 'mason', 'lazy' },
        options = {
            icons_enabled = true,
            theme = gruvbox(),
            component_separators = { left = '', right = '' },
            section_separators = {
                left = right,
                right = left,
            },
            disabled_filetypes = {
                statusline = {
                    'packer',
                    'NvimTree',
                },
                winbar = {
                    'packer',
                    'NvimTree',
                },
            },
            globalstatus = true,
        },
        sections = {
            lualine_a = {
                {
                    'mode',
                    separator = {
                        left = left,
                        right = right,
                    },
                    right_padding = 0
                },
                { 'searchcount', maxcount = 999 },
            },
            lualine_b = { { os_icon }, 'branch', 'diff' },
            lualine_c = {
                'filetype',
                'filesize',
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic', 'nvim_lsp' },
                    sections = { 'error', 'warn' },
                },
            },

            lualine_x = { 'encoding' },
            lualine_y = { 'progress',
                'selectioncount',
                {
                    'filename',
                    path = 1
                },
                { symbol_maker },
            },
            lualine_z = {
                lsp_info,
                {
                    'location',
                    separator = {
                        left = left,
                        right = right,
                    },
                    left_padding = 0
                },
            }
        },
    })
end

return custom;
