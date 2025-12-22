return function()
  local ok, mason = pcall(require, "mason")
  if not ok then
    vim.notify("Failed to load mason: " .. tostring(mason), vim.log.levels.ERROR)
    return
  end

  local setup_ok, err = pcall(mason.setup, {
    ui = {
      border = "rounded",
    },
  })
  if not setup_ok then
    vim.notify("Failed to setup mason: " .. tostring(err), vim.log.levels.ERROR)
  end
end
