v = {
    ["pause"]   = 2,
    ["channel"] = 1001,
    ["cmdchan"] = 1002,
    ["modem"]   = peripheral.find("modem"),
    ["name"]    = os.getComputerLabel(),
}


function v:RefillSlot(slot) -- refill selectrf slot
    local n = 1
    while turtle.getItemCount(slot) < 64 and n < 15 do
	if n ~= slot then
	    turtle.select(n)
	    if turtle.compareTo(slot) then
		turtle.transferTo(slot,64)
	    end
	    slot = slot + 1
	end
    end
end


function v:FindChest()
    for i = 1,4 do 
	local c = peripheral.wrap("front")
	if c ~= nil and c.size ~= nil and c.list ~= nil then
		local used = 0
		for _ in pairs(c.list()) do used = used + 1 end
		if c.size == 27 and used == 0 then return true end
	end
	turtle.turnRight()
    end
    print("Empty chest not found")
    exit(1)
end


function v:SendStat(name, value, color)
    if color == nil then color = colors.white end
    self.modem.transmit(self.channel, self.channel, self.name..":"..name..":"..value..":"..color)
end


function v:Run()
    require(self.name)
end


local ftable = {
    ["stop"] = function() exit() end,
    ["yell"] = function() print("YELL") end,
}


function Listen()
    v.modem.open(v.cmdchan)
    while true do
	local _, _, chan, _, msg, _ = os.pullEvent("modem_message")
	if chan ~= v.channel then print("]",v.name,"]" , chan, " - ", msg) end
	if chan == v.cmdchan then
	    local _, _, comp, command = string.find(msg, "^([^ ]+) (.+)$")
        print("]]", comp, "]", command)
	    if comp == v.name then ftable[command]() end
	end
    end
end



return(v)