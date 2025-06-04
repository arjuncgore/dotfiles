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

local make_res = function(width, height, enable, disable)
	return function()
		local active_width, active_height = waywall.active_res()

		if active_width == width and active_height == height then
			waywall.set_resolution(0, 0)
			disable()
		else
			waywall.set_resolution(width, height)
			enable()
		end
	end
end



local resolutions = {
	thin = make_res(350, 1100, thin_enable, generic_disable),
	tall = make_res(320, 16384, tall_enable, tall_disable),
	wide = make_res(2560, 400, wide_enable, generic_disable),
}


config.actions = {
    ["J"] = resolutions.thin,
    ["K"] = resolutions.wide,
    ["L"] = resolutions.tall,

}

return config

