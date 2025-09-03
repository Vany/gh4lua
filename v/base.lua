local state = {}
local color = {}

function Display()
    local m = peripheral.find("monitor")
    v.modem.open(v.channel)

    while true do
        local _, _, channel, _, msg, _ = os.pullEvent("modem_message")
        if channel == v.channel then
            local _, _, k, v = string.find(msg, "([^:]+:[^:]+):(.+)")
            local c = colors.white
            --	if cc = string.find(c, ":([^:]+)") ~= nil then c = cc end
            local header = k .. " - " .. v .. " - " .. c
            state[k] = v
            color[k] = c

            local l = 1
            m.clear()
            m.setCursorPos(1, 1); m.setTextColor(colors.white); m.write("===> " .. header)
            for k, v in pairs(state) do
                l = l + 1
                m.setCursorPos(1, l); m.setTextColor(color[k]); m.write(k .. "  : " .. v)
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
