local checking = false
local job_ids = {}

local function stop_job(job_id)
  if job_id and vim.fn.jobwait({ job_id }, 0)[1] == -1 then
    vim.fn.jobstop(job_id)
  end
end

local function check()
  if checking then return end
  checking = true

  for _, job_id in ipairs(job_ids) do
    stop_job(job_id)
  end
  job_ids = {}

  local config_location = vim.fn.stdpath("config")
  local git = "git -C " .. config_location .. " "
  local remote_branch = "origin/main"

  local fetch_job = vim.fn.jobstart(git .. "-c http.timeout=5 fetch", {
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        vim.schedule(function()
          vim.notify("Failed to fetch git updates (exit code: " .. exit_code .. ")", vim.log.levels.DEBUG)
          checking = false
        end)
        return
      end

      local count_job = vim.fn.jobstart(git .. "rev-list --left-right --count " .. remote_branch .. "...HEAD", {
        stdout_buffered = true,
        on_exit = function() checking = false end,
        on_stdout = function(_, data)
          local first = data[1]
          if not first then return end

          local ahead, behind = first:match("^(%d+)%s+(%d+)$")
          if not ahead or not behind then return end

          if ahead ~= "0" or behind ~= "0" then
            vim.schedule(function()
              vim.notify(
                "Configuration is out of date. [ ↓ " .. ahead .. " | ↑ " .. behind .. " ]",
                vim.log.levels.WARN,
                { hide_from_history = true }
              )
            end)
          end
        end,
        on_stderr = function(_, data)
          if data and data[1] and data[1] ~= "" then
            vim.schedule(function()
              vim.notify("Error checking git status: " .. table.concat(data, "\n"), vim.log.levels.DEBUG)
            end)
          end
        end,
      })
      job_ids[#job_ids + 1] = count_job
    end,
    on_stderr = function(_, data)
      if data and data[1] and data[1] ~= "" then
        vim.schedule(function()
          vim.notify("Git fetch error: " .. table.concat(data, "\n"), vim.log.levels.DEBUG)
          checking = false
        end)
      end
    end,
  })
  job_ids[#job_ids + 1] = fetch_job
end

return { check = check }
