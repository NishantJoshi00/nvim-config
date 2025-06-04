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



    local lsp_info = {
        function()
            local msg = ""
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
                return msg
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                end
            end
            return msg
        end,
        color = { fg = '#2a2a2a', gui = 'bold' },
        separatorr = "",
    }

    local symbol_maker = function()
        if lsp_info[1]() == "" then
            return "  "
        else
            return '  '
        end
    end

    local os_icon = function()
        local os = vim.loop.os_uname().sysname
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
