local slots = 4

for slot = 1, slots do
    turtle.select(slot)
    for i = 1, 64 do
	       turtle.place()
        turtle.select(slots)
	       while turtle.compare() do
	          os.sleep(1)
	       end
        turtle.select(slot)
        turtle.dig()
    end
end
