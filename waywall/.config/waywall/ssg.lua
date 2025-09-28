local waywall = require("waywall")
local helpers = require("waywall.helpers")

local pacem_path = "/home/arjungore/mcsr/paceman-tracker-0.7.0.jar"

local remaps_enabled = {
	["MB4"] = "F3",
	["MB5"] = "F6",
	["F6"] = "MB5",
	["LEFTALT"] = "LEFTCTRL",

	["T"] = "BACKSPACE",
	["BACKSPACE"] = "T",
	["A"] = "K",
	["Z"] = "A",
	["K"] = "CAPSLOCK",
	["O"] = "Q",
	["Q"] = "O",
	["D"] = "X",
	["X"] = "RIGHTSHIFT",
	["RIGHTSHIFT"] = "D",
	["F1"] = "I",
	["I"] = "F1",
	["CAPSLOCK"] = "Z",
}

local remaps_disabled = {
	["MB4"] = "F3",
	["MB5"] = "F6",
	["F6"] = "MB5",
	["LEFTALT"] = "LEFTCTRL",
}

local config = {
	input = {
		layout = "us",
		repeat_rate = 40,
		repeat_delay = 300,
		remaps = remaps_enabled,
		sensitivity = 1.0,
		confine_pointer = false,
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

local rebind_text = nil

--*********************************************************************************************** KEYBINDS
config.actions = {

	["F6"] = function()
		waywall.press_key("F6")
	end,

	["*-MB5"] = function()
		waywall.press_key("F6")
	end,

	["Shift-O"] = waywall.toggle_fullscreen,

	["Shift-P"] = function()
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
