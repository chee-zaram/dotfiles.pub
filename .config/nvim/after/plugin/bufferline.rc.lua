local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup({
    options = {
        mode = 'tabs',
        separation_style = 'slant',
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icons = false,
    },
    highlights = {
        separator = {
            fg = '#073642',
            bg = '#002b36'
        },
        separator_selected = {
            fg = '#073642'
        },
        background = {
            fg = '#657b83',
            bg = '#002b36'
        },
        buffer_selected = {
            fg = '#fdf6e3',
            bold = true, italic = false
        },
        fill = {
            fg = '#073642'
        }
    }
})

vim.api.nvim_set_keymap('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', {})
vim.api.nvim_set_keymap('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', {})
