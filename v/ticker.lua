local counter = 0
while true do
	v:SendStat("tick", counter)
	sleep(1)
	print("Tick")
	counter = counter + 1
end