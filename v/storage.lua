local chest = peripheral.wrap("back")

while true do
	local size = chest.size()
	local list = chest.list()
	local used = 0
	for _ in pairs(list) do used = used + 1 end
	print(size .. " / " .. used)
	v:SendStat("storage", size .. " / " .. used)
	sleep(5)
end
