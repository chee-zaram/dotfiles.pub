local M = {}

M.treesitter = {
	highlight = {
		enable = true,
		disable = {},
	},

	indent = {
		enable = true,
		disable = {},
	},

	ensure_installed = {
		-- defaults
		"vim",
		"lua",
		"comment",
		"gitcommit",
		"json",
		"yaml",

		-- web dev
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"json",
		"markdown",
		"markdown_inline",
		"python",
		"go",
		"bash",

		-- low level
		"c",
		"zig",
		"rust",
	},

	autotag = {
		enable = true,
	},
}

M.mason = {
	ensure_installed = {
		-- Web dev
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",

		-- Lua
		"lua-language-server",
		"stylua",

		-- Go
		"gopls",
		"gofumpt",

		-- Python
		"python-lsp-server",
		"blue",

		-- Shell
		"bash-language-server",
		"shellcheck",
		"shfmt",

		-- Configuration
		"yaml-language-server",
		"yq",
		"dockerfile-language-server",
	},

	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
}

M.conform = {
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		-- python = { "isort", "black" },
		python = { "blue" },
		-- python = { "autopep8" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },

		typescript = { "deno" },

		go = { "gofumpt" },

		yaml = { "yq" },

		sh = { "shfmt" },
	},

	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
}

-- One dark configuration options
M.onedark = {
	style = "darker",
	transparent = true,
	lualine = {
		transparent = true,
	},
	code_style = {
		functions = "bold",
		variables = "none",
	},
}

M.cmp = {
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "codeium" },
	},
}

M.saga = {
	server_filetype_map = {},
}

return M
