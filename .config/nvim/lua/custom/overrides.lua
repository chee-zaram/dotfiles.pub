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
		-- Formatters
		"prettier",
		"stylua",
		"gofumpt",
		"blue",
		"shellcheck",
		"shfmt",

		-- LSPs
		"gopls",
		"python-lsp-server",
		"bash-language-server",
		"lua-language-server",
		"yaml-language-server",
		"html-lsp",
		"typescript-language-server",
		"html-lsp",
		"css-lsp",
		"deno",
		"prettier",
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

		go = { "gofumpt" },
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

return M
