local modem = peripheral.wrap("top")
local chest = peripheral.wrap("back")
local pause = 2
local channel = 1001
local name = os.getComputerLabel()

modem.open(channel)

while true do
	os.pullEvent("redstone")
	local left = rs.getInput("left")
	local right = rs.getInput("right")
	local bottom = rs.getInput("bottom")
	print(left, right, bottom)
	local work = not left and not right and bottom
	modem.transmit(channel, channel, name..":RL:".. tostring(work) .. " = " ..tostring(left) .. " + " .. tostring(right) )
	rs.setOutput("back", work)
end

