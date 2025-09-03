v.ft["forcestop"] = function()
    print("Force stoped")
    exit()
end



local counter = 0
while true do
    v:SendStat("tick", counter)
    print("Tick")
    counter = counter + 1
    v:sound("minecraft:block.note_block.pling")
    sleep(1)
end
