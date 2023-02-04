local status, tokyonight = pcall(require, 'tokyonight')
if (not status) then return end

tokyonight.setup({
    style = "night",
    styles = {
        functions = {}
    },
    sidebars = { "qf", "vista_kind", "terminal", "packer" },
    on_colors = function(colors)
        colors.comment = "#895656"
        colors.bg_visual = "#2a324f"
    end
})
--[[
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true
--]]
