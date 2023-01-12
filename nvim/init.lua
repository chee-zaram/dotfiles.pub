require('cheezaram.base')
require('cheezaram.highlights')
require('cheezaram.maps')
require('cheezaram.plugins')

local has = vim.fn.has
local mac = has "macunix"
local win = has "win32"

if mac then
	require('cheezaram.unix')
end

if win then
	require('cheezaram.winos')
end
