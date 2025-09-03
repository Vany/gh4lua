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

while true do
    v:SendStat("battery", math.floor(EnderCell() * 100) .. "%")
    sleep(5)
end
