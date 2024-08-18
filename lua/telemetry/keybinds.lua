---
--- Telemetry: Keybinds
---
--- This fill is responsible for adding telemetry functionality to all the keybinds.
--- This is a optional functionality that can be enabled or disabled by the user.
--- This can help the user to understand how the keybinds are being used and how often.
---
--- Note: Adding this functionality can have a performance impact on the system. Use it only if you wish to analyze the keybinds usage.
---
---



---@param mode string
---@param f function
---@return nil
---
--- Here the function `f` will be provided with the current mode, and the keybind data.
function keybinds(mode, f)
  for _, data in ipairs(vim.api.nvim_get_keymap(mode)) do
    local opts = {
      noremap = data.noremap,
      nowait = data.nowait,
      silent = data.silent,
      script = data.script,
      desc = data.desc,
    }

    local exec = function(...) end;

    if data.rhs ~= nil then
      -- remove <Cmd> and <CR> from the rhs
      local command = string.gsub(data.rhs, "<Cmd>", "")
      command = string.gsub(command, "<CR>", "")

      exec = function(...)
        vim.cmd(command)
      end
    else
      exec = data.callback
    end
    local callback = function(...)
      exec(...)
      f(mode, data.lhs, data.desc)
    end

    opts.callback = callback;
    vim.api.nvim_set_keymap(mode, data.lhs, "", opts)
  end
end

if require("telemetry.metrics").config.keybinds.telemetry then
  vim.notify("Keybind-analyzer active", vim.log.levels.INFO, { hide_from_history = true, title = "Telemetry" })
  local filename = require("telemetry.metrics").filename
  for _, mode in ipairs(require("telemetry.metrics").config.keybinds.modes) do
    keybinds(mode, function(m, key, desc)
      require("telemetry").increment(filename, m, key, desc)
    end)
  end
end
