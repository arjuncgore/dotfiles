local waywall = require("waywall")
local helpers = require("waywall.helpers")

-- local nb_overlay = require("nb_overlay")

local primary_col = "#d08e2b"
local secondary_col = "#48b0af"
local shadow_col = "#CCCCCC"

local background_path = "/home/arjungore/mcsr/resources/bg_final.png"
local screen_overlay_path = "/home/arjungore/mcsr/resources/overlay_final.png"

local pacem_path = "/home/arjungore/mcsr/paceman-tracker-0.7.0.jar"
local nb_path = "/home/arjungore/mcsr/Ninjabrain-Bot-1.5.1.jar"
local overlay_path = "/home/arjungore/mcsr/resources/stretched_overlay.png"

local remaps_active = true
local current_remap = "resetting"

local keymaps_resetting = {
	["MB4"] = "F3",
	["LEFTALT"] = "LEFTCTRL",

	["Q"] = "O",
	["D"] = "X",
	["CAPSLOCK"] = "Z",
}

local remaps_enabled = {
	["MB4"] = "F3",
	["MB5"] = "F6", ["F6"] = "MB5",
	["LEFTALT"] = "LEFTCTRL",

	["T"] = "BACKSPACE", ["BACKSPACE"] = "T",
	["A"] = "K", ["Z"] = "A", ["K"] = "CAPSLOCK",
	["O"] = "Q", ["Q"] = "O",
	["D"] = "X", ["X"] = "RIGHTSHIFT", ["RIGHTSHIFT"] = "D",
	["F1"] = "I", ["I"] = "F1",
	["CAPSLOCK"] = "Z",
}

local remaps_disabled = {
	["MB4"] = "F3",
	["MB5"] = "F6", ["F6"] = "MB5",
	["LEFTALT"] = "LEFTCTRL",
}


local config = {
    input = {
        layout = "us",
        repeat_rate = 40,
        repeat_delay = 300,
		remaps = remaps_enabled,
        sensitivity = 1.0,
        confine_pointer = true,
    },
    theme = {
        background_png = background_path,
        ninb_anchor = "topright",
		ninb_opacity = 0.8,
    },
    experimental = {
        debug = false,
        jit = false,
        tearing = false,
		scene_add_text = true,
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
		src = { x = 1, y = 28, w = 49, h = 18 },
		dst = { x = 1500, y = 400, w = 343, h = 126 },
		color_key = {
			input = "#dddddd",
			output = secondary_col,
		},
	}),

	e_counter_bg = make_mirror({
		src = { x = 1, y = 28, w = 49, h = 18 },
		dst = { x = 1507, y = 407, w = 343, h = 126 },
		color_key = {
			input = "#dddddd",
			output = shadow_col,
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

	thin_percent_blockentities_bg = make_mirror({
		src = { x = 257, y = 879, w = 33, h = 25 },
		dst = { x = 1576, y = 1058, w = 264, h = 200 },
		color_key = {
			input = "#e96d4d",
			output = shadow_col,
		},
    }),
	thin_percent_unspecified_bg = make_mirror({
		src = { x = 257, y = 879, w = 33, h = 25 },
		dst = { x = 1576, y = 1058, w = 264, h = 200 },
		color_key = {
			input = "#45cb65",
			output = shadow_col,
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

	tall_percent_blockentities_bg = make_mirror({
		src = { x = 291, y = 16163, w = 33, h = 25 },
		dst = { x = 1576, y = 1058, w = 264, h = 200 },
		color_key = {
			input = "#e96d4d",
			output = shadow_col,
		},
    }),
	tall_percent_unspecified_bg = make_mirror({
		src = { x = 291, y = 16163, w = 33, h = 25 },
		dst = { x = 1576, y = 1058, w = 264, h = 200 },
		color_key = {
			input = "#45cb65",
			output = shadow_col,
		},
    }),


	eye_measure = make_mirror({
		src = { x = 177, y = 7902, w = 30, h = 580 },
		dst = { x = 94, y = 470, w = 900, h = 500 },
	}),
}


--*********************************************************************************************** IMAGES
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
	mirrors.e_counter_bg(f3)

    -- mirrors.thin_pie_all(thin)
    mirrors.thin_pie_entities(thin)
    mirrors.thin_pie_unspecified(thin)
    mirrors.thin_pie_blockentities(thin)
    mirrors.thin_pie_destroyProgress(thin)
    mirrors.thin_pie_prepare(thin)

	-- mirrors.thin_percent_all(thin)
	mirrors.thin_percent_blockentities(thin)
	mirrors.thin_percent_unspecified(thin)
	mirrors.thin_percent_blockentities_bg(thin)
	mirrors.thin_percent_unspecified_bg(thin)

	-- mirrors.tall_pie_all(tall)
    mirrors.tall_pie_entities(tall)
    mirrors.tall_pie_unspecified(tall)
    mirrors.tall_pie_blockentities(tall)
    mirrors.tall_pie_destroyProgress(tall)
    mirrors.tall_pie_prepare(tall)

	-- mirrors.tall_percent_all(tall)
	mirrors.tall_percent_blockentities(tall)
	mirrors.tall_percent_unspecified(tall)
	mirrors.tall_percent_blockentities_bg(tall)
	mirrors.tall_percent_unspecified_bg(tall)


end


--*********************************************************************************************** STATES
local thin_enable = function()
    show_mirrors(false, true, false, true)
end

local tall_enable = function()
	show_mirrors(true, true, true, false)
end
local wide_enable = function()
	show_mirrors(false, false, false, false)
end

local tall_disable = function()
	show_mirrors(false, false, false, false)
end

local generic_disable = function()
    show_mirrors(false, false, false, false)
end


--*********************************************************************************************** RESOLUTIONS
local make_res = function(width, height, enable, disable)
	return function()
		local active_width, active_height = waywall.active_res()

		if active_width == width and active_height == height then
			os.execute('echo "0x0" > ~/.resize_state')
			waywall.sleep(17)
			waywall.set_resolution(0, 0)
			disable()
		else
			os.execute(string.format('echo "%dx%d" > ~/.resize_state', width, height))
			waywall.sleep(17)
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

local rebind_text = nil


--*********************************************************************************************** KEYBINDS
config.actions = {
	["*-Alt_L"] = function()
		if current_remap ~= "enabled" then
			current_remap = "enabled"
			waywall.set_remaps(remaps_enabled)
		end
		if remaps_active then
			resolutions.thin()
		end
	end,

	["F6"] = function()
		current_remap = "resetting"
		waywall.set_remaps(keymaps_resetting)
		return false
	end,

	["*-MB5"] = function()
		print("\n\n\n" .. waywall.state().screen .. "\n\n\n")

		if (current_remap == "resetting") then
			waywall.press_key("F6")
		end
	end,

	["*-B"] = function()
		if remaps_active then
			if not waywall.get_key("F3") then
				resolutions.wide()
			else
				return false
			end
		else
			return false
		end
	end,

	["*-F4"] = function()
		if remaps_active then
			if not waywall.get_key("F3") then
				resolutions.tall()
			else
				return false
			end
		end
	end,

	["apostrophe"] = function()
		if remaps_active then
			helpers.toggle_floating()
		end
	end,

	["Shift-O"] = waywall.toggle_fullscreen,

	["Shift-P"] = function()
		exec_ninb()
		exec_pacem()
	end,

	["Insert"] = function()
		if rebind_text then
			rebind_text:close()
			rebind_text = nil
		end
		remaps_active = not remaps_active
		waywall.set_remaps(remaps_active and remaps_enabled or remaps_disabled)
		if not remaps_active then
			rebind_text = waywall.text("REBINDS OFF", 30, 1380, "#FFFFFF", 3)
		end
	end,

}


return config