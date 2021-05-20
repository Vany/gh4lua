local slots = 6

while turtle.getItemCount(1) > 0 do
    for slot = 1,slots do
        turtle.select(slot)
        turtle.dropDown(1)
    end
    sleep(8)
    turtle.select(15)
    turtle.dropDown(1)
    turtle.select(16)
    sleep(0.5)
    turtle.placeDown()
    sleep(1)
end
