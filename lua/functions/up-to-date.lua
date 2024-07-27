-- This function checks if the current version of the neovim configuration is up-to-date.


-- This function performs the following steps:
-- 1. Locates the currently active configuration.
-- 2. Checks if the configuration is up-to-date with the remote repository.
-- 3. If the configuration is not up-to-date, it will prompt the user to update the configuration. (using vim.notify)
--
local function check()
  local config_location = vim.fn.stdpath("config")

  local git = "git -C " .. config_location .. " "

  vim.fn.jobstart(git .. "fetch", {
    on_exit = function()
      vim.fn.jobstart(git .. "rev-list --left-right --count origin/lazy-lua...HEAD", {
        stdout_buffered = true,
        on_stdout = function(_, data, _)
          local first = data[1]
          local ahead, behind = first:match("^(%d+)%s+(%d+)$")

          if ahead ~= "0" or behind ~= "0" then
            vim.notify("Configuration is out of date. 󰇚" .. ahead .. " 󰕒" .. behind, vim.log.levels.WARN,
              { hide_from_history = true })
          end
        end
      })
    end
  })
end

check()
