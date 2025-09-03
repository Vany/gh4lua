v = {
    ["pause"]   = 2,
    ["channel"] = 1001,
    ["cmdchan"] = 1002,
    ["modem"]   = peripheral.find("modem"),
    ["speaker"] = peripheral.find("speaker"),
    ["name"]    = os.getComputerLabel(),
    ["ft"]      = {
        ["stop"] = function() exit() end,
        ["yell"] = function() print("YELL") end,
    }
}

function v:sound(name)
    if not self.speaker then return end
    self.speaker.playSound(name, 1, 1)
end

function v:BucketFuel(slot)
    if turtle.getFuelLimit() < turtle.getFuelLevel() * 1.2 then return end
    turtle.select(slot)
    turtle.suck(1)
    turtle.refuel(1)
    turtle.drop(1)
end

function v:RefillSlot(slot) -- refill selectrf slot
    local n = 1
    while turtle.getItemCount(slot) < 64 and n < 15 do
        if n ~= slot then
            turtle.select(n)
            if turtle.compareTo(slot) then
                turtle.transferTo(slot, 64)
            end
        end
        n = n + 1
    end
    turtle.select(slot)
end

function v:FindChest()
    for i = 1, 4 do
        local c = peripheral.wrap("front")
        if c ~= nil and c.size ~= nil and c.list ~= nil then
            local used = 0
            for _ in pairs(c.list()) do used = used + 1 end
            if c.size() == 27 and used == 0 then return true end
        end
        turtle.turnRight()
    end
    print("Empty chest not found")
    exit(1)
end

function v:SendStat(name, value, color)
    if color == nil then color = colors.white end
    self.modem.transmit(self.channel, self.channel, self.name .. ":" .. name .. ":" .. value .. ":" .. color)
end

function v:Run()
    print("==> ", self.name, " <==")
    require(self.name)
end

function Listen()
    v.modem.open(v.cmdchan)
    while true do
        local _, _, chan, _, msg, _ = os.pullEvent("modem_message")
        if chan == v.cmdchan then
            local _, _, comp, command = string.find(msg, "^([^ ]+) (.+)$")
            if comp == v.name then v.ft[command]() end
        end
    end
end

return (v)
