local modem = peripheral.wrap("top")
local chest = peripheral.wrap("back")
local pause = 2
local channel = 1001
local name = os.getComputerLabel()

modem.open(channel)

while true do
	local size = chest.size()
	local list = chest.list()
	local used = 0
	for _ in pairs(list) do used = used + 1 end
	print(size .. " / " .. used)
	modem.transmit(channel, channel, name..":chest:".. size .. " / " .. used )
	sleep(pause)
end

