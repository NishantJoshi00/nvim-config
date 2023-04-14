local evil_lualine_config = function()
  -- Eviline config for lualine
  -- Author: shadmansaleh
  -- Credit: glepnir
  local lualine = require('lualine')

  -- Color table for highlights
  -- stylua: ignore
  local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#ec5f67',
  }

  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand('%:p:h')
      local gitdir = vim.fn.finddir('.git', filepath .. ';')
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

  -- Config
  local config = {
    options = {
      -- Disable sections and component separators
      component_separators = '',
      section_separators = '',
      theme = {
        -- We are going to use lualine_c an lualine_x as left and
        -- right section. Both are highlighted by c theme .  So we
        -- are just setting default looks o statusline
        normal = { c = { fg = colors.fg, bg = colors.bg } },
        inactive = { c = { fg = colors.fg, bg = colors.bg } },
      },
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      -- These will be filled later
      lualine_c = {},
      lualine_x = {},
    },
    inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
  }

  -- Inserts a component in lualine_c at left section
  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  -- Inserts a component in lualine_x at right section
  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end

  local mode_color = {
    n = colors.red,
    i = colors.green,
    v = colors.blue,
    [''] = colors.blue,
    V = colors.blue,
    c = colors.magenta,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [''] = colors.orange,
    ic = colors.yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ['r?'] = colors.cyan,
    ['!'] = colors.red,
    t = colors.red,
  }


  ins_left {
    function()
      local size = {
        i = '████',
        n = '█',
        v = '██',
        V = '██',
        [''] = '███',
      }
      return size[vim.fn.mode()] or '█'
    end,
    color = function()
      return { fg = mode_color[vim.fn.mode()] }
    end,                               -- Sets highlighting of component
    padding = { left = 0, right = 1 }, -- We don't need space before this
  }

  ins_left {
    -- mode component
    function()
      -- return ''
      return '⽕ ' .. vim.fn.mode()
    end,
    color = function()
      -- auto change color according to neovims mode
      local mode_color = {
        n = colors.red,
        i = colors.green,
        v = colors.blue,
        [''] = colors.blue,
        V = colors.blue,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red,
      }
      return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 1 },
  }

  ins_left {
    -- filesize component
    'filesize',
    cond = conditions.buffer_not_empty,
  }

  ins_left {
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = colors.magenta, gui = 'bold' },
  }

  ins_left { 'location' }

  ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

  ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
      color_error = { fg = colors.red },
      color_warn = { fg = colors.yellow },
      color_info = { fg = colors.cyan },
    },
  }

  -- Insert mid section. You can make any number of sections in neovim :)
  -- for lualine it's any number greater then 2
  ins_left {
    function()
      return '%='
    end,
  }

  ins_left {
    -- Lsp server name .
    function()
      local msg = 'default'
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
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
    icon = '⛭ LSP:',
    color = { fg = '#ffffff', gui = 'bold' },
  }

  -- Add components to right sections
  ins_right {
    'o:encoding',       -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = 'bold' },
  }

  ins_right {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    color = { fg = colors.green, gui = 'bold' },
  }

  ins_right {
    'branch',
    icon = '',
    color = { fg = colors.violet, gui = 'bold' },
  }

  ins_right {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = ' ', modified = '柳 ', removed = ' ' },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.orange },
      removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
  }

  ins_right {
    function()
      local size = {
        i = '████',
        n = '█',
        v = '██',
        V = '██',
        [''] = '███',
      }
      return size[vim.fn.mode()] or '█'
    end,
    color = function()
      return { fg = mode_color[vim.fn.mode()] }
    end, -- Sets highlighting of component
    padding = { left = 1 },
  }

  -- Now don't forget to initialize lualine
  lualine.setup(config)
end

local rust_analyzer_config = function()
  local rt = require("rust-tools")
  rt.setup {
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "<c-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        vim.keymap.set("v", "<c-space>", rt.code_action_group.code_action_group, { buffer = bufnr })

        vim.api.nvim_set_keymap('n', '<c-.>', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})
        vim.api.nvim_set_keymap('v', '<c-.>', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})
      end,
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
            }
          },
          cargo = {
            buildScripts = {
              overrideCommand = nil
            }
          },
          diagnostics = {
            disabled = {
              "unresolved-macro-call"
            }
          },
          completion = {
            autoimport = {
              enable = true,
            }
          },
          procMacro = {
            enable = true,
            attributes = {
              enable = true
            }
          },

        }
      }
    }
  }
end

local disabled_on = function(systems)
  for _, val in ipairs(systems) do
    if vim.fn.has(val) == 1 then
      return true
    end
  end
  return false
end


local quoter = function()
  vim.fn.jobstart("curl -s https://zenquotes.io/api/random | jq '.[0][\"q\"]'", {
    stdout_buffered = true,
    on_stdout = function(a, b, c)
      -- print(vim.inspect(b))
      vim.notify(b[1])
    end,
  })
end
vim.g.quote_me = quoter


local random_footer = function()
  local footers = {
    "🚀 Sharp tools make good work.",
    "🥛 Boost is the secret of my energy.",
    "⛰  Washing powder nirma",
    "📜 Luck is the planning, that you don't see."
  }
  math.randomseed(os.time())
  return footers[math.random(1, #footers)]
end


return {
  lualine_config = evil_lualine_config,
  rust_analyzer_config = rust_analyzer_config,
  disabled_on = disabled_on,
  quoter = quoter,
  dashboard_footer = random_footer
}
