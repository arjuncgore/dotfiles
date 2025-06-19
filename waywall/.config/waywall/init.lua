local waywall = require("waywall")
local helpers = require("waywall.helpers")

local primary_col = "#272420"
local secondary_col = "#9a774f"

local background_path = "/home/arjungore/mcsr/resources/background.png"
local nb_path = "/home/arjungore/mcsr/Ninjabrain-Bot-1.5.1.jar"
local overlay_path = "/home/arjungore/mcsr/resources/measuring_overlay.png"


local config = {
    input = {
        layout = "us",
        repeat_rate = 40,
        repeat_delay = 300,
        
        remaps = {
		    ["MB4"] = "F3",                                             -- F3 with back button
		    ["MB5"] = "F6",                                             -- Reset with forward button
            ["LEFTALT"] = "LEFTCTRL",                                   -- LALT --> LCTRL
            
            ["T"] = "PAGEUP", ["PAGEUP"] = "T",                         -- PgUp <--> T
            ["A"] = "PAGEDOWN", ["PAGEDOWN"] = "A",                     -- PgDn <--> A
			["O"] = "Q", ["Q"] = "O",                     				-- PgDn <--> A
            ["RIGHTSHIFT"] = "X", ["X"] = "RIGHTSHIFT",                 -- RShift <--> H

        },

        sensitivity = 1.0,
        confine_pointer = false,
    },
    theme = {
        background_png = background_path,
        ninb_anchor = "topright",
    },
    experimental = {
        debug = false,
        jit = false,
        tearing = false,
    },
}


--=============================================================================================== NINJABRAIN
local is_ninb_running = function()
	local handle = io.popen("pgrep -f 'Ninjabrain.*jar'")
	local result = handle:read("*l")
	handle:close()
	return result ~= nil
end

local exec_ninb = function()
	if not is_ninb_running() then
		waywall.exec("java -jar " .. nb_path)
	end
end

--=============================================================================================== MIRRORS
local make_mirror = function(options)
	local this = nil

	return function(enable)
		if enable and not this then
			this = waywall.mirror(options)
		elseif this and not enable then
			this:close()
			this = nil
		end
	end
end

local mirrors = {
    e_counter = make_mirror({
		src = {  x = 1, y = 28, w = 49, h = 18 },
		dst = { x = 1500, y = 400, w = 343, h = 126 },
		color_key = {
			input = "#dddddd",
			output = primary_col,
		},
	}),

    thin_pie_all = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = 1500, y = 657, w = 400, h = 400 },
    }),
    thin_pie_entities = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = 1500, y = 657, w = 400, h = 400 },
		color_key = {
			input = "#E446C4",
			output = secondary_col,
		},
	}),
    thin_pie_unspecified = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = 1500, y = 657, w = 400, h = 400 },
		color_key = {
			input = "#46CE66",
			output = secondary_col,
		},
	}),
    thin_pie_blockentities = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = 1500, y = 657, w = 400, h = 400 },
		color_key = {
			input = "#ec6e4e",
			output = primary_col,
		},
	}),
	thin_pie_destroyProgress = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = 1500, y = 657, w = 400, h = 400 },
		color_key = {
			input = "#CC6C46",
			output = secondary_col,
		},
	}),
	thin_pie_prepare = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = 1500, y = 657, w = 400, h = 400 },
		color_key = {
			input = "#464C46",
			output = secondary_col,
		},
	}),

	tall_pie_all = make_mirror({
		src = { x = 44, y = 15978, w =340, h = 178 },
        dst = { x = 1500, y = 657, w = 400, h = 400 },
	}),
	tall_pie_entities = make_mirror({
		src = { x = 44, y = 15978, w =340, h = 178 },
        dst = { x = 1500, y = 657, w = 400, h = 400 },
		color_key = {
			input = "#E446C4",
			output = secondary_col,
		},
	}),
    tall_pie_unspecified = make_mirror({
		src = { x = 44, y = 15978, w =340, h = 178 },
        dst = { x = 1500, y = 657, w = 400, h = 400 },
		color_key = {
			input = "#46CE66",
			output = secondary_col,
		},
	}),
    tall_pie_blockentities = make_mirror({
		src = { x = 44, y = 15978, w =340, h = 178 },
        dst = { x = 1500, y = 657, w = 400, h = 400 },
		color_key = {
			input = "#ec6e4e",
			output = primary_col,
		},
	}),
	tall_pie_destroyProgress = make_mirror({
		src = { x = 44, y = 15978, w =340, h = 178 },
        dst = { x = 1500, y = 657, w = 400, h = 400 },
		color_key = {
			input = "#CC6C46",
			output = secondary_col,
		},
	}),
	tall_pie_prepare = make_mirror({
		src = { x = 44, y = 15978, w =340, h = 178 },
        dst = { x = 1500, y = 657, w = 400, h = 400 },
		color_key = {
			input = "#464C46",
			output = secondary_col,
		},
	}),

	eye_measure = make_mirror({
		src = { x = 162, y = 7902, w = 60, h = 580 },
		dst = { x = 94, y = 470, w = 900, h = 500 },
	}),
}

--=============================================================================================== BOATEYE
local make_image = function(path, dst)
	local this = nil

	return function(enable)
		if enable and not this then
			this = waywall.image(path, dst)
		elseif this and not enable then
			this:close()
			this = nil
		end
	end
end

local images = {
	overlay = make_image(overlay_path, {
		dst = { x = 94, y = 470, w = 900, h = 500 },
	}),
}

local ratbag_device = io.popen("ratbagctl list | grep 'Glorious Model O' | awk -F ':' '{print $1}'"):read("*l")

local reset_dpi = function()
	if not ratbag_device then return end

	local current_dpi_cmd = string.format("ratbagctl '%s' dpi get", ratbag_device)
	local current_dpi = io.popen(current_dpi_cmd):read("*a")
	current_dpi = current_dpi:gsub("^%s*(.-)%s*$", "%1")

	if current_dpi == "100x100dpi" then
		local set_dpi_cmd = string.format("ratbagctl '%s' dpi set 3200", ratbag_device)
		os.execute(set_dpi_cmd)
	end
end

--=============================================================================================== MANAGING MIRRORS
local show_mirrors = function(eye, f3, tall, thin)
	images.overlay(eye)
	mirrors.eye_measure(eye)

    mirrors.e_counter(f3)

    -- mirrors.thin_pie_all(thin)
    mirrors.thin_pie_entities(thin)
    mirrors.thin_pie_unspecified(thin)
    mirrors.thin_pie_blockentities(thin)
    mirrors.thin_pie_destroyProgress(thin)
    mirrors.thin_pie_prepare(thin)

	-- mirrors.tall_pie_all(tall)
    mirrors.tall_pie_entities(tall)
    mirrors.tall_pie_unspecified(tall)
    mirrors.tall_pie_blockentities(tall)
    mirrors.tall_pie_destroyProgress(tall)
    mirrors.tall_pie_prepare(tall)

end

--=============================================================================================== STATES
local thin_enable = function()
	-- reset_dpi()
    show_mirrors(false, true, false, true)
end

local tall_enable = function()
	-- if ratbag_device then
	-- 	os.execute(string.format("ratbagctl '%s' dpi set 100", ratbag_device))
	-- end
	show_mirrors(true, true, true, false)
end
local wide_enable = function()
	show_mirrors(false, false, false, false)
end

local tall_disable = function()
	-- reset_dpi()
	show_mirrors(false, false, false, false)
end

local generic_disable = function()
    show_mirrors(false, false, false, false)
end

--=============================================================================================== RESOLUTIONS
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
	tall = make_res(384, 16384, tall_enable, tall_disable),
	wide = make_res(2560, 400, wide_enable, generic_disable),
}

--=============================================================================================== KEYBINDS
config.actions = {

    ["*-Alt_L"] = resolutions.thin,
    ["*-Z"] = resolutions.wide,
    ["*-F4"] = function()
        if not waywall.get_key("F3") then
            resolutions.tall()
        else
            return false
        end
    end,

	["Shift-P"] = exec_ninb,
	
	["apostrophe"] = function()
		helpers.toggle_floating()
	end,
	
	["Shift-O"] = function()
		waywall.toggle_fullscreen()
	end,

}

return config

