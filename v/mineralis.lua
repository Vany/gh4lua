function TurnLeft(x,z)
    return z, -x
end

function TurnRight(x,z)
    return -z, x
end


function FindHome(xh,yh,zh,wx,wz)

    local x1,y1,z1 = gps.locate(2,true)
    if x1 == nil then
        print("Can't determine location")
        exit(0)
    end


    -- try to move
    while not turtle.forward() do
        turtle.turnLeft()
    end

    local x2,y2,z2 = gps.locate(2,true)
    if x2 == nil then
        print("Can't determine location 2")
        exit(0)
    end


    local thx, thz = x2 - xh, z2 - zh
    local dx, dz = x2 - x1, z2 - z1

    -- Go toward Xhome
    if dx ~= 0 and dx * thx > 0 then
        turtle.turnLeft(); turtle.turnLeft()
        dx = -dx
    elseif dz * thx > 0 then
        turtle.turnRight()
        dx,dz = TurnRight(dx,dz)
    elseif dz * thx < 0 then
        turtle.turnLeft()
        dx,dz = TurnLeft(dx,dz)
    end
    for i = 1, math.abs(thx) do turtle.forward() end


    if dz ~= 0 and dz * thz > 0 then
        turtle.turnLeft(); turtle.turnLeft()
        dz = -dz
    elseif dx * thz < 0 then
        turtle.turnRight()
        dx,dz = TurnRight(dx,dz)
    elseif dx * thz > 0 then
        turtle.turnLeft()
        dx,dz = TurnLeft(dx,dz)
    end
    for i = 1, math.abs(thz) do turtle.forward() end


    if dx * wx < 0 or dz * zh < 0 then turtle.turnLeft();turtle.turnLeft() end

end

function Unload()
    for slot = 2,16 do
        turtle.select(slot)
        turtle.drop(64)
    end
end

function Load(slot)
    turtle.select(slot)
    while turtle.getItemCount(slot) < 64 do
        turtle.suck(64 - turtle.getItemCount(slot))
        sleep(1)        
    end
end

function Fuel(slot)
    if turtle.getFuelLimit() < turtle.getFuelLevel()*2 then return end
    turtle.select(slot)
    turtle.suck(64)
    turtle.refuel(64)
end

function BucketFuel(slot)
    if turtle.getFuelLimit() < turtle.getFuelLevel()*2 then return end
    turtle.select(slot)
    turtle.suck(1)
    turtle.refuel(1)
    turtle.drop(1)
end


function DigBlock()
    while turtle.compareDown() do sleep(2) end
    turtle.digDown()
    turtle.placeDown()
    turtle.digUp()
    turtle.placeUp()
    v:RefillSlot(1)
end

function DigField(wx,wz)
    for x = 1, math.abs(wx) do
        for z = 1, math.abs(wz)-1 do
            DigBlock()
            turtle.forward()
        end
        DigBlock()

        if x % 2 > 0 then
            turtle.turnLeft(); turtle.forward(); turtle.turnLeft()
        else
            turtle.turnRight(); turtle.forward(); turtle.turnRight()
        end

    end
end

function Mineralis(hx,hy,hz,wx,wz)
    while true do
        FindHome(hx,hy,hz,wx,wz)

        -- maintenance
        turtle.forward()
        turtle.turnLeft()
        Unload()
        turtle.turnRight()
        Load(1); Load(2)
        turtle.turnRight()
        v:BucketFuel(3); v:BucketFuel(3)
        turtle.turnRight()
        turtle.select(1)
        turtle.forward()
        DigField(wx,wz)
    end
end
