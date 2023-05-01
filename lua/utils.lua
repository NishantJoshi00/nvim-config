local is_day = function()
	local current_hour = tonumber(os.date("%H"))
	if current_hour > 11 and current_hour < 18 then
		return true
	else
		return false
	end
end

return {
	is_day = is_day,
}
