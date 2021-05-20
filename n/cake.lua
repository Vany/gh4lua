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



while true do 
    getItems()
    turtle.select(15)
    turtle.craft(1)
    turtle.drop()
--    while turtle.getItemCount() > 0 do
--        turtle.placeDown()
--        os.sleep(1)
--    end
end
