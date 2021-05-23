-- try CC inventory here, it will allow not to turn arround

function suckone(slot)
    turtle.select(slot)
    while turtle.getItemCount() < 1 do
        turtle.suck(1)
        os.sleep(1)
    end
end

function getItems()
    turtle.select(1); turtle.placeUp()
    turtle.select(2); turtle.placeUp()
    turtle.select(3); turtle.placeUp()

    turtle.turnRight();
    suckone(6);
    turtle.turnRight(); 
    suckone(9); suckone(10); suckone(11)

    turtle.turnRight();
    suckone(5); suckone(7)
    turtle.turnRight();
end




v:FindChest()

local cakes = 0
while true do 
    getItems()
    turtle.select(15)
    turtle.craft(1)
    turtle.drop()
    cakes = cakes + 1
    v:SendStat("cakes", cakes)
end
