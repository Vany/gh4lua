local modem = peripheral.wrap("top")
local pause = 2
local channel = 1001
local name = os.getComputerLabel()

modem.open(channel)

local state = {}

while true do
	local _, _, _, _, msg, _ = os.pullEvent("modem_message")
	print(msg)
end