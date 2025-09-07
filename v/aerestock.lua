local ae = peripheral.find("me_bridge")
if ae == nil then
    error("No ME Bridge found")
    return nil
end

v:SendStat("HAVE", "INIT", "yellow")
function makeErr(error)
    v:SendStat("ERROR", error, "red")
    print(error)
    os.exit()
end

local cpus, err = ae.getCraftingCPUs()
if cpus == nil then makeErr("No cpus found") end

function haveFreeCPU()
    for i, cpu in ipairs(cpus) do
        if not cpu.isBusy then
            return true
        end
    end
    return false
end

local KeepCrafted = {}
KeepCrafted.__index = KeepCrafted

function stack(name, keep)
    local self = setmetatable({}, KeepCrafted)
    self.name = name or "" -- tag
    self.keep = keep       -- how much to keep--
    self.job = nil         -- we are not crafting it right now
    local i, err = ae.getItem({ name = name })
    if i == nil then makeErr(name .. " =>  " .. err) end
    if not ae.isCraftable(i) then makeErr(name .. " => Not craftable") end
    self.count = i.count
    self.fitem = { fingerprint = i.fingerprint }
    return self
end

function KeepCrafted:needCraft()
    -- todo shortcut if nojob
    local i, err = ae.getItem(self.fitem)
    if i == nil then makeErr(self.name .. " => " .. (err or "NIL")) end
    self.count = i.count

    if self.job ~= nil then
        print(self.name, self.job.isDone())
        if self.job.isDone() or self.job.isCanceled() then
            self.job = nil
        else
            return false
        end
    end

    if self.count >= self.keep then
        return false
    end
    --    local is, err = ae.isCrafting(self.fitem)
    return not ae.isCrafting({ name = self.name })
end

function KeepCrafted:craft()
    local todo = self.keep - self.count
    local crf = { fingerprint = self.fitem.fingerprint, count = todo }
    -- print(textutils.serialize(crf))
    local job, err = ae.craftItem(crf)
    print("Crafting " .. self.name, todo, job, err)
    if not job then
        print(self.name .. " " .. err); return false
    else
        self.job = job
    end
    return true
end

local keep = {
    --    stack("mekanism:energy_tablet", 64),
    stack("ftbmaterials:steel_ingot", 4096),
    stack("ae2:calculation_processor", 1024),
    stack("ae2:logic_processor", 1024),
    stack("ae2:engineering_processor", 1024),
    stack("mekanism:alloy_infused", 2048),
    stack("mekanism:alloy_reinforced", 2048),
    stack("mekanism:alloy_atomic", 2048),

    --   stack("extendedae:concurrent_processor", 128),
    stack("megacells:accumulation_processor", 128),
}

print("Started...")
v:SendStat("ERROR", "-", "black") -- cleanup error line
local total, thisCycle, thisCycleErrors = 0, 0, 0
while true do
    local error = ""
    for _, item in ipairs(keep) do
        if item:needCraft() and haveFreeCPU() then
            if item:craft() then
                thisCycle = thisCycle + 1
                print("ok")
            else
                print("not ok")
                thisCycleErrors = thisCycleErrors + 1
                error = item.name
            end
        end
        sleep(0.1)
    end

    if error ~= "" then
        v:SendStat("HAVE", error .. "!", "red")
    else
        v:SendStat("HAVE", total .. " " .. thisCycle .. "!", "green")
    end

    print("...")
    sleep(1)
end

return nil
