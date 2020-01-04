local listname = "/g4l.txt"
local prefix = "https://raw.githubusercontent.com/"
-- string -> string
function _GET(path)
    local handle = http.get(prefix .. path)
    if handle.getResponseCode() ~= 200 then
        return "", false
    end
    local content = handle.readAll()
    handle.close()
    return content, true
end

function _DUMP(t)
    for k,v in pairs(t) do
        print(k, ":\t", v)
    end
end

function clone(repo, branch) --> bool
    local curdir = shell.dir() .. "/"
    if branch == nil then
        branch = "master"
    end
  
    if repo == nil then
        if fs.exists(curdir .. listname) then 
            h = fs.open(curdir .. listname, "r")
            local s = h.readLine()
            h.close()
            if s ~= nil then
                _, _, r, b = string.find(s, "([^%s]+)%s+([^%s]+)")
                return clone(r, b)
            end
        else
            print("Please specify repository")
            return false 
        end
    end

    local repopath = repo .. "/" .. branch .. "/"
    local filelist, ok = _GET(repopath .. listname)

    if not ok then 
        return (print("repository have no "..listname.." in the repo ".. repo) and false)
    end

    local first = true
    for fname in string.gmatch(filelist, "([^\n]+)") do
        if first then 
            first = false 
        else
            print("Retrieving: ", fname)
            local content, ok = _GET(repopath .. fname)
            if not ok then 
                print("..unexisted")
            else
                local h = fs.open(curdir .. fname, "w")
                h.write(content)
                h.close()
            end
        end
    end
end

if false then
local s, ok = _GET("Vany/gh4lua/master/README.md")
print(s, ok)
end

clone()