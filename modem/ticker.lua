local modem = peripheral.wrap("top")
local pause = 2
local channel = 1001
local name = os.getComputerLabel()

modem.open(channel)

local counter = 0
while true do
	modem.transmit(channel, channel, name..":tick"..counter)
	sleep(pause)
	print("Tick")
end