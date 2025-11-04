-- This function checks if the current version of the neovim configuration is up-to-date.


-- This function checks if the current version of the neovim configuration is up-to-date.
--
local function check()
  local config_location = vim.fn.stdpath("config")

  local git = "git -C " .. config_location .. " "

  local remote = "origin"
  local branch = "main"
  local remote_branch = remote .. "/" .. branch


  vim.fn.jobstart(git .. "-c http.timeout=5 fetch", {
    on_exit = function(_, exit_code, _)
      if exit_code ~= 0 then
        vim.notify("Failed to fetch git updates (exit code: " .. exit_code .. ")", vim.log.levels.DEBUG)
        return
      end

      vim.fn.jobstart(git .. "rev-list --left-right --count " .. remote_branch .. "...HEAD", {
        stdout_buffered = true,
        on_stdout = function(_, data, _)
          local first = data[1]
          if not first then return end

          local ahead, behind = first:match("^(%d+)%s+(%d+)$")
          if not ahead or not behind then return end

          if ahead ~= "0" or behind ~= "0" then
            vim.notify("Configuration is out of date. [ ↓ " .. ahead .. " | ↑ " .. behind .. " ]", vim.log.levels.WARN,
              { hide_from_history = true })
          end
        end,
        on_stderr = function(_, data, _)
          if data and #data > 0 and data[1] ~= "" then
            vim.notify("Error checking git status: " .. table.concat(data, "\n"), vim.log.levels.DEBUG)
          end
        end,
      })
    end,
    on_stderr = function(_, data, _)
      if data and #data > 0 and data[1] ~= "" then
        vim.notify("Git fetch error: " .. table.concat(data, "\n"), vim.log.levels.DEBUG)
      end
    end,
  })
end

return {
  check = check
}
