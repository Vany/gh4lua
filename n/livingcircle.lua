function Circle(sub)
    for i = 1,4 do
        turtle.forward(); sub()
        turtle.forward(); turtle.turnLeft(); sub()
    end
end

function FillSlot()
    slot = 2
    while turtle.getItemCount(1) < 64 and slot < 15 do
        turtle.select(slot)
        if turtle.compareTo(1) then
            turtle.transferTo(1,64)
        end
        slot =  slot+1
    end
end

local modem = peripheral.wrap("left")
local channel = 1001
local name = os.getComputerLabel()
modem.open(channel)

local runs = 0
while turtle.getItemCount(1) > 7 do
    FillSlot()
    turtle.select(1)
    while turtle.compareDown() do
        sleep(1)
    end
    runs = runs + 1
    modem.transmit(channel, channel, name..":Runs:".. runs)
    print("runs: ", runs)    
    Circle(function() turtle.digDown(); turtle.placeDown() end)

end
