local waywall = require("waywall")
local json = require("dkjson")

local NB_OVERLAY = {}

local data_stronghold = nil
local data_blind = nil
local data_boat = nil

local text_handle = nil
local text_handle_bold = nil

local look = {
    X = 500,
    Y = 10,
    fill = '#000000',
    outline = '#000000',
    size = 2
}

local full_background_toggle = nil
function NB_OVERLAY.set_full_background(func)
    full_background_toggle = func
end

local partial_background_toggle = nil
function NB_OVERLAY.set_partial_background(func)
    partial_background_toggle = func
end


local function angle_to_destination(x_pos, z_pos, x_dest, z_dest)
    local dx = x_dest - x_pos
    local dz = z_dest - z_pos
    local angle_rad = math.atan2(-dx, dz)
    local angle_deg = math.deg(angle_rad)
    if angle_deg > 180 then
        angle_deg = angle_deg - 360
    elseif angle_deg < -180 then
        angle_deg = angle_deg + 360
    end
    return angle_deg
end

local function getdirection(player_angle, target_angle)
    local diff = target_angle - player_angle
    if diff > 180 then diff = diff - 360 end
    if diff < -180 then diff = diff + 360 end

    if diff > 3 then
        return "Right "
    elseif diff < -3 then
        return "Left "
    else
        return ""
    end
end

local function nb_mode()
    if not data_stronghold or not data_stronghold.playerPosition then
        return "NB Ready"
    elseif data_stronghold.resultType == "BLIND" then
        return "Blinding"
    elseif data_stronghold.predictions and data_stronghold.predictions[1] and data_stronghold.predictions[1].certainty >= 0.95 then
        return "Nether Travel"
    else
        return "Measuring"
    end
end

local function boat_status()
    if not data_boat or not data_boat.boatState then
        return "Error"
    elseif data_boat.boatState == "MEASURING" or data_boat.boatState == "ERROR" then
        return "Not Ready"
    elseif data_boat.boatState == "VALID" then
        return "Ready"
    else
        return "Error"
    end
end

local function update_overlay()
    if text_handle then
        text_handle:close()
        text_handle = nil
    end

    if text_handle_bold then
        text_handle_bold:close()
        text_handle_bold = nil
    end

    if nb_mode() == "NB Ready" then
        return
    end

    local player = data_stronghold.playerPosition or {
        xInOverworld = 0,
        zInOverworld = 0,
        horizontalAngle = 0
    }

    local sh = data_stronghold.predictions and data_stronghold.predictions[1] or {
        chunkX = 0,
        chunkZ = 0,
        overworldDistance = 0
    }

    local layout =
    "Status:" .. nb_mode() .. "\n" ..
    "Boat? :" .. boat_status() .. "\n"
    full_background_toggle(false)
    partial_background_toggle(true)


    if data_stronghold and data_stronghold.predictions
    and data_stronghold.predictions[1]
    and data_stronghold.predictions[1].certainty
    and data_stronghold.predictions[1].certainty < 0.95
    then
        local cert = math.floor(data_stronghold.predictions[1].certainty * 100)
        layout =
        "Status   :" .. nb_mode() .. "\n" ..
        "Certainty:" .. cert .. "%\n"
        full_background_toggle(false)
        partial_background_toggle(true)

    end


    if nb_mode() == "Nether Travel" then
        local sh_x, sh_z, distance
        local px, pz

        if player.isInOverworld then
            sh_x = math.floor(16 * (sh.chunkX or 0) + 4)
            sh_z = math.floor(16 * (sh.chunkZ or 0) + 4)
            px = player.xInOverworld
            pz = player.zInOverworld
            distance = math.floor(sh.overworldDistance or 0)

        elseif player.isInNether then
            sh_x = math.floor(2 * (sh.chunkX or 0))
            sh_z = math.floor(2 * (sh.chunkZ or 0))
            px = player.xInOverworld / 8
            pz = player.zInOverworld / 8
            distance = math.floor((sh.overworldDistance or 0) / 8)
        end

        local angle = angle_to_destination(px, pz, sh_x, sh_z)
        local diff = angle - player.horizontalAngle
        if diff > 180 then diff = diff - 360 end
        if diff < -180 then diff = diff + 360 end

        local turn = getdirection(player.horizontalAngle, angle)

        layout = 
            "Status  :" .. nb_mode() .. "\n" ..
            "Coords  :(" .. sh_x .. "," .. sh_z .. ")\n" ..
            "Distance:" .. distance .. " blocks\n" ..
            "Angle   :" .. string.format("%.2f", angle) .. " deg\n" ..
            "Turn    :" .. turn .. "(" .. math.floor(math.abs(diff)) .. " deg)\n"
        full_background_toggle(true)
        partial_background_toggle(false)

    end

    local state = waywall.state()
    if state and state.screen == "inworld" then
        text_handle = waywall.text(layout, look.X, look.Y, look.fill, look.size)
        text_handle_bold = waywall.text(layout, look.X+1, look.Y, look.outline, look.size)
    end
end

NB_OVERLAY.trigger_http_send = function()
    local sh_idx = waywall.http_request("http://localhost:52533/api/v1/stronghold", 150)
    waywall.listen("http", function()
        local sh_data = waywall.http_retrieve(sh_idx)
        if sh_data then
            data_stronghold = json.decode(tostring(sh_data))

            local blind_idx = waywall.http_request("http://localhost:52533/api/v1/blind", 150)
            waywall.listen("http", function()
                local blind_data = waywall.http_retrieve(blind_idx)
                if blind_data then
                    data_blind = json.decode(tostring(blind_data))

                    local boat_idx = waywall.http_request("http://localhost:52533/api/v1/boat", 150)
                    waywall.listen("http", function()
                        local boat_data = waywall.http_retrieve(boat_idx)
                        if boat_data then
                            data_boat = json.decode(tostring(boat_data))
                            update_overlay()
                        end
                    end)
                end
            end)
        end
    end)
end

NB_OVERLAY.enable_overlay = function()
    NB_OVERLAY.trigger_http_send()
end

NB_OVERLAY.disable_overlay = function()
    if text_handle then text_handle:close(); text_handle = nil end
    if text_handle_bold then text_handle_bold:close(); text_handle_bold = nil end
    if full_background_toggle then
        full_background_toggle(false)
    end
    if partial_background_toggle then
        partial_background_toggle(false)
    end
end

return NB_OVERLAY
