local sizex = 48
local sizey = 48
local parity = 0

local step = 0
local slot = 1

function place()
	step = step + 1
	if math.fmod(step, 2) == parity then
		return
	end
	
	turtle.select(slot)
	if turtle.getItemCount() == 0 then
		slot = slot + 1
		turtle.select(slot)
	end

	turtle.placeDown()
end

for x=1, sizex do
	for y=1, sizey do 
		turtle.forward()
		place()
	end
	local turn
	if math.fmod(x,2) == 1 then
		 turn = turtle.turnRight
	else
		 turn = turtle.turnLeft
	end

	turn()
	turtle.forward()
	turn()
	place()
end


