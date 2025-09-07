local state = {}
local color = {}

local crs = {
    [""]      = colors.white,
    ["1"]     = colors.white,
    ["white"] = colors.white,
    ["green"] = colors.green,
    ["red"]   = colors.red,
    ["alarm"] = colors.red,
}

function Display()
    local m = peripheral.find("monitor")
    v.modem.open(v.channel)

    v:sound("minecraft:entity.cat.beg_for_food")
    sleep(1)
    v:sound("minecraft:entity.cat.beg_for_food")

    while true do
        local _, _, channel, _, msg, _ = os.pullEvent("modem_message")
        if channel == v.channel then
            local _, _, k, n, c = string.find(msg, "([^:]+:[^:]+):(.+):(.*)$")
            print(msg)
            if c == nil then c = "white" end
            if n == nil then n = "NONE" end
            local header = k .. " - " .. n .. " - " .. c
            print(k .. " - " .. n .. " - " .. c)
            if c == "alarm" then v:sound("minecraft:block.note_block.pling") end
            if c == "alarm" then v:sound("minecraft:entity.cat.beg_for_food") end
            state[k] = n
            color[k] = crs[c]
            local l = 1
            m.clear()
            m.setCursorPos(1, 1);
            m.setTextColor(colors.white);
            m.write("===> " .. header)
            for k, n in pairs(state) do
                l = l + 1
                m.setCursorPos(1, l); m.setTextColor(color[k]); m.write(k .. "  : " .. n)
            end
        end
    end
end

local history = {}
function Commands()
    while true do
        write("> ")
        local cmd = read(nil, history, nil, "")
        if cmd == "stop" then return end
        v.modem.transmit(v.cmdchan, v.cmdchan, cmd)
    end
end

parallel.waitForAny(Display, Commands)

os.exit(0)
