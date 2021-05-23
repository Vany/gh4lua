local counter = 0
while true do
    v:RefillSlot(1)
    turtle.place()
    while turtle.compare() do
	os.sleep(1)
    end
    turtle.dig()
    counter = counter + 1
    v:SendStat("dig", counter)
end
