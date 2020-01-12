local modem = peripheral.wrap("top")
local bat = peripheral.wrap("back")
local pause = 2
local channel = 1001
local name = os.getComputerLabel()

modem.open(channel)

local counter = 0
while true do
	local fill = bat.getMaxEnergyStored() / bat.getEnergyStored()
	modem.transmit(channel, channel, name..":Fill:".. fill)
	modem.transmit(channel, channel, name..":Feed:".. bat.getTransferPerTick())	
	sleep(pause)
	print("Tick")
end