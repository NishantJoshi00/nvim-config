---@return boolean
local function is_day()
  local hour = tonumber(os.date("%H"))
  return hour > 11 and hour < 18
end

---Execute `fun` only if all `feature` flags are present.
---@param feature table|nil|string
---@param fun function
local function gate(feature, fun)
  if feature == nil then
    fun()
  elseif type(feature) == "string" then
    if vim.fn.has(feature) == 1 then
      fun()
    end
  elseif type(feature) == "table" then
    for _, f in ipairs(feature) do
      if vim.fn.has(f) == 0 then
        return
      end
    end
    fun()
  end
end

return {
  is_day = is_day,
  gate = gate,
}
