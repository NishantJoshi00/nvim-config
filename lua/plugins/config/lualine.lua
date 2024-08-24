local custom = function()
  local gruvbox = function()
    local colors = { -- Gruvbox Dark
      darkgray = "#282828",
      gray = "#928374",
      innerbg = nil,
      outerbg = "#1d2021",
      normal = "#458487",
      insert = "#689c69",
      visual = "#cb231d",
      replace = "#d69821",
      command = "#98961a",
    }

    return {
      inactive = {
        a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      visual = {
        a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      replace = {
        a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      normal = {
        a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      insert = {
        a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      command = {
        a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
    }
  end


  local left = "";
  local right = "";

  local tright = "";
  local tleft = "";


  local unix = '';
  local dos = '';
  local mac = '';



  local lsp_info = {
    function()
      local msg = ""
      local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
      local clients = vim.lsp.get_active_clients()
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
    color = { fg = '#ffffff', gui = 'bold' },
    separator = "",
  }

  local symbol_maker = function()
    if lsp_info[1]() == "" then
      return ""
    else
      return ''
    end
  end

  require('lualine').setup({
    extensions = { 'oil', 'fzf', 'mason', 'lazy' },
    options = {
      icons_enabled = true,
      theme = gruvbox(),
      component_separators = { left = '', right = '' },
      section_separators = {
        -- slash
        left = right,
        -- slash
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
        'searchcount',
      },
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        'filetype',
        'filesize',
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'error', 'warn', 'info' },
        },
      },

      lualine_x = { 'encoding' },
      lualine_y = { 'progress' },
      lualine_z = {
        'selectioncount',
        { symbol_maker },
        lsp_info,
        {
          'filename',
          path = 1
        },
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
