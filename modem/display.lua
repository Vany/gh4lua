local modem = peripheral.wrap("top")
local pause = 2
local channel = 1001
local name = os.getComputerLabel()

modem.open(channel)

local state = {}

while true do
	nil, nil, nil, msg, nil = os.pull_event("modem_message")
	print(msg)
end