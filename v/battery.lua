local cell = peripheral.wrap("back")
if not cell then
    v:SendStat("battery", "NO BATTERY")
    error("No battery found")
    exit()
end

function EnderCell()
    local energy = cell.getStoredEnergy()
    local capacity = cell.getMaxEnergy()
    print("Energy:", energy, "Capacity:", capacity)
    return energy / capacity
end

local treshhold = 25

while true do
    local percentage = math.floor(EnderCell() * 100)
    local color = percentage < 50 and "red" or "green"
    if percentage < treshhold then color = "alarm" end
    v:SendStat("HAVE", percentage .. "%", color)
    sleep(percentage < treshhold and 1 or 5)
end
