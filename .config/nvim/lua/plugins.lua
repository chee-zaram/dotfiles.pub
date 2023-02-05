local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end

local _, packer = pcall(require, 'packer')

packer.startup(function(use)
    -- packer plugin manager
    use 'wbthomason/packer.nvim'

    -- Themes and colorschemes
    use {
        'svrana/neosolarized.nvim',
        requires = { 'tjdevries/colorbuddy.nvim' }
    }
    use 'norcalli/nvim-colorizer.lua'
    use 'folke/tokyonight.nvim'
    use 'MunifTanjim/prettier.nvim'
    use 'navarasu/onedark.nvim' -- For atom inspired theme

    -- Lsp Plugins
    use({
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
    })

    -- File icons
    use 'kyazdani42/nvim-web-devicons'

    -- Snippets
    use 'L3MON4D3/LuaSnip'

    -- Statusline
    use 'hoob3rt/lualine.nvim'

    -- vscode-line pictograms
    use 'onsails/lspkind-nvim'

    -- Syntax highlighting and more
    use {
        'nvim-treesitter/nvim-treesitter',
        --		run = ':TSUpdate'
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    -- Auto insert pair character for characters that are used in pairs
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'

    -- Fuzzy finder
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'

    -- Display filetype icons in tabs
    use 'akinsho/nvim-bufferline.lua'

    -- Useful Git and GitHub plugins
    use 'lewis6991/gitsigns.nvim' -- Git signs
    use 'dinhhuy258/git.nvim' -- For git blame & browser
    use 'tpope/vim-fugitive' -- Use git commands from withig neovim
    use 'tpope/vim-rhubarb' -- For opening file in GitHub front end with fugitive

    -- C plugins
    use 'p00f/clangd_extensions.nvim'

    -- Get preview of markdown files as you type
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- Common utilities
    use 'nvim-lua/plenary.nvim'
    use 'lukas-reineke/indent-blankline.nvim'

    -- chatgpt neovim plugin
    use({
        "jackMort/ChatGPT.nvim",
        config = function()
            require("chatgpt").setup({
                -- optional configuration
            })
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    })

    --[[ Visualize lsp progress
    use({
    	"j-hui/fidget.nvim",
    	config = function()
    		require("fidget").setup()
    	end
    }) ]]

    -- File explorer type plugin
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- For auto-commenting
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- For debugging
    use 'mfussenegger/nvim-dap'

    -- Rust tool
    use 'simrat39/rust-tools.nvim'

    local has_plugins, plugins = pcall(require, 'custom.plugins')
    if has_plugins then
        plugins(use)
    end

    if is_bootstrap then
        require('packer').sync()
    end
end)

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})
