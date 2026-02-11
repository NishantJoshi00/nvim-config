return function()
    local color = require("exports").colors

    local theme = {
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

    local sep = { left = "", right = "" }

    -- Compute OS icon once (never changes at runtime)
    local os_icon = (function()
        local sysname = vim.uv.os_uname().sysname
        if sysname == "Linux" then return "  "
        elseif sysname == "Darwin" then return "  "
        elseif sysname == "Windows" then return "  "
        end
        return ""
    end)()

    -- LSP info with cache invalidated only on LSP events
    local lsp_info_cache = {}

    local function get_lsp_info()
        local bufnr = vim.api.nvim_get_current_buf()
        local buf_ft = vim.bo[bufnr].filetype
        local cache_key = bufnr .. ":" .. buf_ft

        if lsp_info_cache[cache_key] then
            return lsp_info_cache[cache_key]
        end

        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.tbl_contains(filetypes, buf_ft) then
                lsp_info_cache[cache_key] = client.name
                return client.name
            end
        end

        lsp_info_cache[cache_key] = ""
        return ""
    end

    vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
        callback = function() lsp_info_cache = {} end,
    })

    require("lualine").setup({
        extensions = { "oil", "fzf", "mason", "lazy" },
        options = {
            icons_enabled = true,
            theme = theme,
            component_separators = { left = "", right = "" },
            section_separators = { left = sep.right, right = sep.left },
            disabled_filetypes = {
                statusline = { "packer", "NvimTree" },
                winbar = { "packer", "NvimTree" },
            },
            globalstatus = true,
        },
        sections = {
            lualine_a = {
                { "mode", separator = { left = sep.left, right = sep.right }, right_padding = 0 },
                { "searchcount", maxcount = 999 },
            },
            lualine_b = { { function() return os_icon end }, "branch" },
            lualine_c = {
                "filetype",
                "filesize",
                { "diagnostics", sources = { "nvim_diagnostic", "nvim_lsp" }, sections = { "error", "warn" } },
            },
            lualine_x = { "encoding" },
            lualine_y = {
                "progress",
                "selectioncount",
                { "filename", path = 1 },
                { function() return get_lsp_info() == "" and "  " or "  " end },
            },
            lualine_z = {
                { get_lsp_info, color = { fg = "#2a2a2a", gui = "bold" }, separator = "" },
                { "location", separator = { left = sep.left, right = sep.right }, left_padding = 0 },
            },
        },
    })
end
