local state = {}
local color = {}

function Display()
    local m = peripheral.find("monitor")
    v.modem.open(v.channel)
    
    print(m)

    while true do
        local _, _, channel, _, msg, _ = os.pullEvent("modem_message")
	if channel == v.channel then
	    local _, _, k, v = string.find(msg, "([^:]+:[^:]+):(.+)")
	    local c = colors.white
	--	if cc = string.find(c, ":([^:]+)") ~= nil then c = cc end
	    local header = k.. " - "..  v .. " - " .. c
	    state[k] = v
	    color[k] = c

	    local l = 1
	    m.clear()
	    m.setCursorPos(1,1); m.setTextColor(colors.white); m.write("===> " .. header)
	    for k,v in pairs(state) do
		l = l + 1
		m.setCursorPos(1,l); m.setTextColor(color[k]); m.write(k.."  : "..v)
	    end
	end
    end
end


local history = {}
function Commands()
--[[
    local completion = require "cc.shell.completion"
    local tcomps = {}
    for k in pairs(state) do
	local c = string.find(k, "^([^:]+):")
	if c ~= nil then tcomps[c] = 1 end
    end

    local comps = {"base"}
    for k in pairs(tcomps) do table.insert(comps, k) end

    local complete = completion.build(
	{ completion.choice, comps },
	{ completion.choice, { "stop", "reboot", "yell" } }
    )
]]--
    while true do
	write("> ")
	local cmd = read(nil, history, nil, "")
	if cmd == "stop" then return end
	v.modem.transmit(v.cmdchan, v.cmdchan, cmd)
    end
end

parallel.waitForAny(Display, Commands)

os.exit(0)

