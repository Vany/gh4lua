local modem = peripherial.wrap("top")
local pause = 20
local channel = 1001
local name = os.getComputerLabel()

modem.open(channel)

local counter = 0
while true do
	modem.transmit(channel, name..":tick"..counter)
	sleep(pause)
	print("Tick")
end