require('base')
require('highlights')
require('maps')
require('plugins')

if vim.fn.has "unix" then
    require('linuxos')
end
