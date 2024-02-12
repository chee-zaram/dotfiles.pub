-- Leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Highlights
vim.opt.cursorline = true
vim.wo.colorcolumn = "80"
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"

-- Base
vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true

vim.opt.title = true
vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = false
vim.opt.scrolloff = 200
vim.opt.shell = "zsh"
vim.opt.backupskip = "/tmp/*,/private/tmp/*"
vim.opt.undofile = true
vim.opt.undodir = "/tmp/.vim/undodir"
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.ai = true -- Auto indent
vim.opt.si = true -- Smart indent
vim.opt.expandtab = true
vim.opt.wrap = false -- No wrap lines
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.backspace = "start,eol,indent"
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- For abbreviation of frequently misspelled words
vim.cmd.ia({ "mian", "main" })
vim.cmd.ia({ "amin", "main" })
vim.cmd.ia({ "inlcude", "include" })
