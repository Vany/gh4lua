local forcestop = false

ftable["forcestop"] = function() forcestop=true end

while true do
	os.pullEvent("redstone")
	local left = rs.getInput("left")
	local right = rs.getInput("right")
	local bottom = rs.getInput("bottom")
	local work = not left and not right and bottom
	v:SendStat("WRL", tostring(work) .. " = " ..tostring(left) .. " + " .. tostring(right) )
	rs.setOutput("back", work)
	if forcestop then rs.setOutput("back", false) end
end
