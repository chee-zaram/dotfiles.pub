local keymap = vim.keymap

-- Leader to space
vim.g.mapleader = ' '

-- Go to normal mode
keymap.set('i', 'jk', '<esc>')
keymap.set('v', 'jk', '<esc>')
keymap.set('n', '<leader>w', ':w<Return>')
keymap.set('n', '<leader>wo', ':wq<Return>')
keymap.set('n', '<leader>oo', ':q!<Return>')
keymap.set('n', '<leader>qo', ':qa!<Return>')
keymap.set('n', '<leader>wq', ':wqa<Return>')

-- Scrolling
keymap.set('n', '[', '{zz')
keymap.set('n', ']', '}zz')

-- Do not yank with x
keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Open init.lua in split screen
keymap.set('n', '<leader>evim', ':vsplit $MYVIMRC<Return>')
-- Source init.lua
keymap.set('n', '<leader>svim', ':source $MYVIMRC<Return>')

-- Change word to uppercase
keymap.set('i', '<C-o>', '<esc>viwUea')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab
keymap.set('n', '<leader>te', ':tabedit<Return>', { silent = true })

-- Move to tab
keymap.set('n', '<leader>tn', ':tabn<Return>', { silent = true })
keymap.set('n', '<leader>tp', ':tabp<Return>', { silent = true })

-- Split window
keymap.set('n', '<leader>ss', ':split<Return><C-w>w', { silent = true })
keymap.set('n', '<leader>sv', ':vsplit<Return><C-w>w', { silent = true })

-- Move window
keymap.set('n', '<leader><Space>', '<C-w>w')
keymap.set('', 's<left>', '<C-w>h')
keymap.set('', 's<up>', '<C-w>k')
keymap.set('', 's<down>', '<C-w>j')
keymap.set('', 's<right>', '<C-w>l')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- Start terminal in neovim
keymap.set('n', '<leader>st', ':vsplit<Return><C-w>w:terminal<Return>', { silent = true })
-- Escape terminal in neovim
keymap.set('t', '<leader>et', '<C-\\><C-n>')

-- Fugitive
keymap.set('n', '<leader>gw', ':Gwrite<Return>')
keymap.set('n', '<leader>gmv', ':GMove')
keymap.set('n', '<leader>gdel', ':GDelete<Return>')
keymap.set('n', '<leader>grm', ':GRemove<Return>')
keymap.set('n', '<leader>gd', ':Git diff<Return>')
keymap.set('n', '<leader>gl', ':Git log<Return>')
keymap.set('n', '<leader>ga', ':Git add<Return>')
keymap.set('n', '<leader>gcmt', ':Git commit<Return>')

-- NvimTreeToggle
keymap.set('n', '<F6>', ':NvimTreeToggle<Return>')
