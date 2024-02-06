local options = require("custom.overrides")

local plugins = {

	-- Get preview of markdown files as you type
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		config = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"glepnir/lspsaga.nvim",
				branch = "main",
				config = function()
					require("custom.configs.lspsaga")
				end,
			},

			--[[ {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      }, ]]
		},

		config = function()
			require("custom.configs.lspconfig")
		end,
	},

	"folke/neodev.nvim",

	{
		"nvim-treesitter/nvim-treesitter",
		opts = options.treesitter,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = options.mason,
	},

	{
		lazy = false,
		"stevearc/conform.nvim",
		opts = options.conform,
	},

	{
		"tpope/vim-fugitive", -- Use git commands from withig neovim
		lazy = false,
		config = function()
			require("custom.configs.fugitive")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = options.treesitter,
	},

	{ "nvim-treesitter/nvim-treesitter-context", lazy = false },

	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		config = function()
			require("plugins.configs.telescope")
			require("custom.configs.telescope")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
	},

	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("plugins.configs.cmp")
	-- 	end,
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 	},
	-- },

	-- Debugger
	{
		"mfussenegger/nvim-dap",
		init = function()
			require("core.utils").load_mappings("dap")
		end,
	},

	-- Go Debugger to work with nvim-dap
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function(_, opts)
			require("dap-go").setup(opts)
			require("core.utils").load_mappings("dap_go")
		end,
	},

	-- Go extras
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
			require("core.utils").load_mappings("gopher")
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},

	{

		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function(_, opts)
			require("todo-comments").setup(opts)
			require("core.utils").load_mappings("todo")
		end,
	},

	{
		"folke/trouble.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function(_, opts)
			require("trouble").setup(opts)
			require("core.utils").load_mappings("trouble")
		end,
	},

	{
		"navarasu/onedark.nvim", -- For atom inspired theme
		lazy = false,
		opts = options.onedark,
	},

	{
		"jcdickinson/codeium.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
}

return plugins
