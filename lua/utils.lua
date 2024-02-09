---
---@return boolean
local is_day = function()
  local current_hour = tonumber(os.date("%H"))
  if current_hour > 11 and current_hour < 18 then
    return true
  else
    return false
  end
end

---comment
---@param feature table|nil|string
---@param fun function
---@return nil
local gated_execute = function(feature, fun)
  -- check if the feature is a list or value
  if type(feature) == "table" then
    for _, f in ipairs(feature) do
      if vim.fn.has(f) == 0 then
        return
      end
    end
    fun()
  elseif type(feature) == "nil" then
    fun()
  elseif type(feature) == "string" then
    if vim.fn.has(feature) == 1 then
      fun()
    end
  else
    error("Invalid feature type")
  end
end


return {
  is_day = is_day,
  gate = gated_execute
}
