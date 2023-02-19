local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local _, lazy = pcall(require, 'lazy')

lazy.setup({
    -- Themes and colorschemes
    {
        'svrana/neosolarized.nvim',
        dependencies = { 'tjdevries/colorbuddy.nvim' }
    },
    'norcalli/nvim-colorizer.lua',
    'folke/tokyonight.nvim',
    'MunifTanjim/prettier.nvim',
    'navarasu/onedark.nvim', -- For atom inspired theme

    -- Detect tabstops and shiftwidth automatically
    'tpope/vim-sleuth',
    -- Lsp Plugins
    {
        -- LSP
        'neovim/nvim-lspconfig',

        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require('lspsaga').setup({})
        end,

        -- completion
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',

        -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
        'jose-elias-alvarez/null-ls.nvim',

        -- Manage lsp servers
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'folke/neodev.nvim',
    },

    -- File icons
    -- 'kyazdani42/nvim-web-devicons',

    -- Snippets
    'L3MON4D3/LuaSnip',

    -- Statusline
    'hoob3rt/lualine.nvim',

    -- vscode-line pictograms
    'onsails/lspkind-nvim',

    -- Syntax highlighting and more
    {
        'nvim-treesitter/nvim-treesitter',
        --		build = ':TSUpdate'
        build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    },

    -- Auto insert pair character for characters that are used in pairs
    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag',

    -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-file-browser.nvim',

    -- Display filetype icons in tabs
    'akinsho/nvim-bufferline.lua',

    -- Useful Git and GitHub plugins
    'lewis6991/gitsigns.nvim', -- Git signs
    'dinhhuy258/git.nvim', -- For git blame & browser
    'tpope/vim-fugitive', -- Use git commands from withig neovim
    'tpope/vim-rhubarb', -- For opening file in GitHub front end with fugitive

    -- C plugins
    'p00f/clangd_extensions.nvim',

    -- Get preview of markdown files as you type
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- Common utilities
    'nvim-lua/plenary.nvim',
    'lukas-reineke/indent-blankline.nvim',

    -- chatgpt neovim plugin
    {
        "jackMort/ChatGPT.nvim",
        config = function()
            require("chatgpt").setup({
                -- optional configuration
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },

    -- Visualize lsp progress
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end
    },

    -- File explorer type plugin
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    },

    -- For auto-commenting
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    -- For debugging
    'mfussenegger/nvim-dap',

    -- Rust tool
    'simrat39/rust-tools.nvim',
})
