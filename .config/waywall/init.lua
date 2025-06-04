local waywall = require("waywall")
local helpers = require("waywall.helpers")

local config = {
    input = {
        layout = "us",
        repeat_rate = 40,
        repeat_delay = 300,
        
        remaps = {
		    ["MB4"] = "F3",
		    ["MB5"] = "F6",
            ["LEFTALT"] = "LEFTCTRL",
            ["LEFTCTRL"] = "LEFTALT",
        },

        sensitivity = 1.0,
        confine_pointer = false,
    },
    theme = {
        background = "#303030ff",
    },
}

config.actions = {}

return config

