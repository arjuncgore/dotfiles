local waywall = require("waywall")
local helpers = require("waywall.helpers")

-- local nb_overlay = require("nb_overlay")

local primary_col = "#d08e2b"
local secondary_col = "#48b0af"

local background_path = "/home/arjungore/mcsr/resources/bg_final.png"
local screen_overlay_path = "/home/arjungore/mcsr/resources/overlay_final.png"

local pacem_path = "/home/arjungore/mcsr/paceman-tracker-0.7.0.jar"
local nb_path = "/home/arjungore/mcsr/Ninjabrain-Bot-1.5.1.jar"
local overlay_path = "/home/arjungore/mcsr/resources/measuring_overlay.png"

local hotkeys_on = require("hotkeys_state")


local config = {
    input = {
        layout = "us",
        repeat_rate = 40,
        repeat_delay = 300,
        
		remaps = hotkeys_on and {
			["MB4"] = "F3",                                             	-- F3 with back button
			["MB5"] = "F6",                                             	-- Reset with forward button
			["LEFTALT"] = "LEFTCTRL",                                   	-- LALT --> LCTRL
			
			["T"] = "BACKSPACE", ["BACKSPACE"] = "T",						-- Backspace <--> T
			["A"] = "K", ["K"] = "Z", ["Z"] = "A",							-- A --> K --> Z --> A
			["O"] = "Q", ["Q"] = "O",	                     				-- O <--> Q
			["D"] = "X", ["X"] = "RIGHTSHIFT", ["RIGHTSHIFT"] = "D",		-- D --> X --> RSHIFT --> D
			["F1"] = "Y",													-- F1 --> Y

		} or {
			["MB4"] = "F3",                                             	-- F3 with back button
			["MB5"] = "F6",                                             	-- Reset with forward button
			["LEFTALT"] = "LEFTCTRL",                                   	-- LALT --> LCTRL
		},

        sensitivity = 1.0,
        confine_pointer = false,
    },
    theme = {
        background_png = background_path,
        ninb_anchor = "topright",
		ninb_opacity = 0.8,
		font_path = "/usr/share/fonts/TTF/MesloLGSNerdFont-Regular.ttf",
    },
    experimental = {
        debug = false,
        jit = false,
        tearing = false,
    },
}


--*********************************************************************************************** PACEMAN
local is_pacem_running = function()
	local handle = io.popen("pgrep -f 'paceman..*'")
	local result = handle:read("*l")
	handle:close()
	return result ~= nil
end

local exec_pacem = function()
	if not is_pacem_running() then
		waywall.exec("java -jar " .. pacem_path .. " --nogui")
	end
end


--*********************************************************************************************** NINJABRAIN
local is_ninb_running = function()
	local handle = io.popen("pgrep -f 'Ninjabrain.*jar'")
	local result = handle:read("*l")
	handle:close()
	return result ~= nil
end

local exec_ninb = function()
	if not is_ninb_running() then
		waywall.exec("java -Dawt.useSystemAAFontSettings=on -jar " .. nb_path)
	end
end


--*********************************************************************************************** MIRRORS
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
		dst = { x = 1490, y = 645, w = 420, h = 423 },
    }),
    thin_pie_entities = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = 1490, y = 645, w = 420, h = 423 },
		color_key = {
			input = "#E446C4",
			output = secondary_col,
		},
	}),
    thin_pie_unspecified = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = 1490, y = 645, w = 420, h = 423 },
		color_key = {
			input = "#46CE66",
			output = secondary_col,
		},
	}),
    thin_pie_blockentities = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = 1490, y = 645, w = 420, h = 423 },
		color_key = {
			input = "#ec6e4e",
			output = primary_col,
		},
	}),
	thin_pie_destroyProgress = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = 1490, y = 645, w = 420, h = 423 },
		color_key = {
			input = "#CC6C46",
			output = secondary_col,
		},
	}),
	thin_pie_prepare = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = 1490, y = 645, w = 420, h = 423 },
		color_key = {
			input = "#464C46",
			output = secondary_col,
		},
	}),


	thin_percent_all = make_mirror({
		src = { x = 257, y = 879, w = 33, h = 25 },
		dst = { x = 1568, y = 1050, w = 264, h = 200 },
    }),
	thin_percent_blockentities = make_mirror({
		src = { x = 257, y = 879, w = 33, h = 25 },
		dst = { x = 1568, y = 1050, w = 264, h = 200 },
		color_key = {
			input = "#e96d4d",
			output = secondary_col,
		},
    }),
	thin_percent_unspecified = make_mirror({
		src = { x = 257, y = 879, w = 33, h = 25 },
		dst = { x = 1568, y = 1050, w = 264, h = 200 },
		color_key = {
			input = "#45cb65",
			output = secondary_col,
		},
    }),


	tall_pie_all = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
        dst = { x = 1490, y = 645, w = 420, h = 423 },
	}),
	tall_pie_entities = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
        dst = { x = 1490, y = 645, w = 420, h = 423 },
		color_key = {
			input = "#E446C4",
			output = secondary_col,
		},
	}),
    tall_pie_unspecified = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
        dst = { x = 1490, y = 645, w = 420, h = 423 },
		color_key = {
			input = "#46CE66",
			output = secondary_col,
		},
	}),
    tall_pie_blockentities = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
        dst = { x = 1490, y = 645, w = 420, h = 423 },
		color_key = {
			input = "#ec6e4e",
			output = primary_col,
		},
	}),
	tall_pie_destroyProgress = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
        dst = { x = 1490, y = 645, w = 420, h = 423 },
		color_key = {
			input = "#CC6C46",
			output = secondary_col,
		},
	}),
	tall_pie_prepare = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
        dst = { x = 1490, y = 645, w = 420, h = 423 },
		color_key = {
			input = "#464C46",
			output = secondary_col,
		},
	}),


	tall_percent_all = make_mirror({
		src = { x = 291, y = 16163, w = 33, h = 25 },
		dst = { x = 1568, y = 1050, w = 264, h = 200 },
    }),
	tall_percent_blockentities = make_mirror({
		src = { x = 291, y = 16163, w = 33, h = 25 },
		dst = { x = 1568, y = 1050, w = 264, h = 200 },
		color_key = {
			input = "#e96d4d",
			output = secondary_col,
		},
    }),
	tall_percent_unspecified = make_mirror({
		src = { x = 291, y = 16163, w = 33, h = 25 },
		dst = { x = 1568, y = 1050, w = 264, h = 200 },
		color_key = {
			input = "#45cb65",
			output = secondary_col,
		},
    }),


	eye_measure = make_mirror({
		src = { x = 162, y = 7902, w = 60, h = 580 },
		dst = { x = 94, y = 470, w = 900, h = 500 },
	}),
}


--*********************************************************************************************** BOATEYE
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
	measuring_overlay = make_image(overlay_path, {
		dst = { x = 94, y = 470, w = 900, h = 500 },
	}),
	screen_overlay = make_image(screen_overlay_path, {
		dst = { x = 0, y = 0, w = 2560, h = 1440 },
	}),
}


--*********************************************************************************************** MANAGING MIRRORS
local show_mirrors = function(eye, f3, tall, thin)
	images.screen_overlay(f3)

	images.measuring_overlay(eye)
	mirrors.eye_measure(eye)

    mirrors.e_counter(f3)

    -- mirrors.thin_pie_all(thin)
    mirrors.thin_pie_entities(thin)
    mirrors.thin_pie_unspecified(thin)
    mirrors.thin_pie_blockentities(thin)
    mirrors.thin_pie_destroyProgress(thin)
    mirrors.thin_pie_prepare(thin)

	-- mirrors.thin_percent_all(thin)
	mirrors.thin_percent_blockentities(thin)
	mirrors.thin_percent_unspecified(thin)


	-- mirrors.tall_pie_all(tall)
    mirrors.tall_pie_entities(tall)
    mirrors.tall_pie_unspecified(tall)
    mirrors.tall_pie_blockentities(tall)
    mirrors.tall_pie_destroyProgress(tall)
    mirrors.tall_pie_prepare(tall)

	-- mirrors.tall_percent_all(tall)
	mirrors.tall_percent_blockentities(tall)
	mirrors.tall_percent_unspecified(tall)


end


--*********************************************************************************************** STATES
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

-- if hotkey_text then
-- 	hotkey_text:close()
-- 	hotkey_text = nil
-- end
-- hotkey_text = waywall.text((hotkeys_on and "" or "hotkeys off"), 10, 1400, "#FFFFFF", 1)

--*********************************************************************************************** RESOLUTIONS
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

local hotkey_text = nil

--*********************************************************************************************** KEYBINDS
config.actions = hotkeys_on and {
	["*-Alt_L"] = resolutions.thin,

	["*-B"] = function()
		if not waywall.get_key("F3") then
			resolutions.wide()
		else
			return false
		end
	end,

	["*-F4"] = function()
		if not waywall.get_key("F3") then
			resolutions.tall()
		else
			return false
		end
	end,

	["Shift-P"] = function()
		exec_ninb()
		exec_pacem()
	end,

	["apostrophe"] = function()
		helpers.toggle_floating()
	end,

	["Shift-O"] = function()
		waywall.toggle_fullscreen()
	end,

	["Home"] = function()
		if hotkeys_on then
			os.execute("echo return false > ~/.config/waywall/hotkeys_state.lua")
		else
			os.execute("echo return true > ~/.config/waywall/hotkeys_state.lua")
		end
	end,
} or {
	-- Minimal fallback actions when hotkeys are off
	["Shift-P"] = function()
		exec_ninb()
		exec_pacem()
	end,

	["apostrophe"] = function()
		helpers.toggle_floating()
	end,

	["Shift-O"] = function()
		waywall.toggle_fullscreen()
	end,

	["Home"] = function()
		if hotkeys_on then
			os.execute("echo return false > ~/.config/waywall/hotkeys_state.lua")
		else
			os.execute("echo return true > ~/.config/waywall/hotkeys_state.lua")
		end
	end,
}


return config

