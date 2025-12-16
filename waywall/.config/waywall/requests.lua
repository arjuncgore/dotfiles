local waywall = require("waywall")
local json = require("dkjson")

local REQUESTS = {}

REQUESTS.trigger_http_send = function(endpoint, index)
    index = index or 0

    local cache_path = os.getenv("HOME") .. "/.cache/waywall_request" .. tostring(index) .. ".json"
    local command = "curl -sS " .. endpoint .. " -o " .. cache_path

    waywall.exec(command)
    return index
end

REQUESTS.receive_data = function(index)
    index = index or 0
    local cache_path = os.getenv("HOME") .. "/.cache/waywall_request" .. tostring(index) .. ".json"

    local f = io.open(cache_path, "r")
    if not f then
        return { error = "Data not received" }
    end
    local raw_data = f:read("*a")
    f:close()

    local data = json.decode(raw_data)
    return data
end

return REQUESTS
