---@type ChadrcConfig
local M = {}

-- Path to overriding themes
local highlights = require("custom.highlights")

M.ui = {
	theme = "oxocarbon",

	hl_override = highlights.override,
	hl_add = highlights.add,
}

M.plugins = "custom.plugins"

M.mappings = require("custom.mappings")

return M
