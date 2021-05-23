local counter = 0
while turtle.getItemCount(1) > 0 do
    local pool = rs.getAnalogInput("left")
    if  pool < 14 then
	v:RefillSlot(1)
	turtle.select(1)
        turtle.place()
    end
    sleep(3);
    counter = counter + 1
    v:SendStat("s-p-c", string.format("%d-%d-%d",turtle.getItemCount(1), pool, counter))
end
