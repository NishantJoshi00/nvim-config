local filename = vim.fn.stdpath('config') .. "/data/state.bin"

local config = {
  keybinds = {
    modes = { "n" },
    telemetry = true,
    notify = true
  },
}

--- use this if the application panics (in case the state is not present)
local function startup()
  require("telemetry").create(filename)
end

--- use this to export metrics
local function export()
  return require("telemetry").generate(filename)
end

return {
  filename = filename,
  config = config,
  startup = startup,
  export = export,
}
