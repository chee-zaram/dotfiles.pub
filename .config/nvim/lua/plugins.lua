local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end

local _, packer = pcall(require, 'packer')

packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    -- use 'bluz71/vim-nightfly-guicolors' -- another color scheme
    use {
        'svrana/neosolarized.nvim',
        requires = { 'tjdevries/colorbuddy.nvim' }
    }

    use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
    use 'MunifTanjim/prettier.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'folke/neodev.nvim'

    use 'kyazdani42/nvim-web-devicons' -- File icons
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require('lspsaga').setup({})
        end,
    })
    use 'L3MON4D3/LuaSnip' -- Snippet
    use 'hoob3rt/lualine.nvim' -- Statusline
    use 'onsails/lspkind-nvim' -- vscode-line pictograms
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in lsp
    use 'hrsh7th/nvim-cmp' -- completion
    use 'neovim/nvim-lspconfig' -- LSP
    use {
        'nvim-treesitter/nvim-treesitter',
        --		run = ':TSUpdate'
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'

    use 'nvim-lua/plenary.nvim' -- common utilities
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'

    use 'akinsho/nvim-bufferline.lua'
    use 'norcalli/nvim-colorizer.lua'

    use 'lewis6991/gitsigns.nvim' -- Git signs
    use 'dinhhuy258/git.nvim' -- For git blame & brower
    use 'folke/tokyonight.nvim'
    use 'p00f/clangd_extensions.nvim'
    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    --	use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
    -- use 'Yggdroot/indentLine' -- Show indention with thin lines
    use 'lukas-reineke/indent-blankline.nvim'
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
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb' -- For opening file in GitHub front end with fugitive
    -- use("simrat39/rust-tools.nvim")
    -- Visualize lsp progress
    -- use({
    -- 	"j-hui/fidget.nvim",
    -- 	config = function()
    -- 		require("fidget").setup()
    -- 	end
    -- })
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use 'navarasu/onedark.nvim' -- For atom inspired theme

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
