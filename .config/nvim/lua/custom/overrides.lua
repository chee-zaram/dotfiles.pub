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
		"toml",

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
		"templ",

		-- low level
		"c",
		"zig",
		"rust",
	},

	autotag = {
		enable = true,
	},
}

local mason_ensure_installed = {
	-- Web dev
	"css-lsp",
	"html-lsp",
	"htmx-lsp",
	"typescript-language-server",
	"deno",
	"prettier",
	"tailwindcss-language-server",

	-- C
	"clangd",
	"clang-format",

	-- Lua
	"lua-language-server",
	"stylua",

	-- Go
	"gopls",
	"gofumpt",
	"golines",
	"templ",

	-- Python
	-- "python-lsp-server",
	"pyright",
	"ruff-lsp",
	"mypy",
	-- "autopep8",

	-- Shell
	"bash-language-server",
	"shfmt",

	-- Rust
	"rust-analyzer",

	-- Configuration
	"yaml-language-server",
	"dockerfile-language-server",
	"terraform-ls",
}

M.mason = {
	ensure_installed = mason_ensure_installed,
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
}

M.mason_installer = {
	ensure_installed = mason_ensure_installed,
	auto_update = true,
}

M.conform = {
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		-- python = { "isort", "black" },
		-- python = { "autopep8" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },

		typescript = { "deno" },

		go = { "gofumpt", "golines" },

		c = { "clang-format" },

		markdown = { "prettier" },
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

M.code_snap_preview = {
	-- mac_window_bar = false,
	watermark = "Chee-zaram Okeke",
	preview_title = "api.go",
	editor_font_family = "JetBrainsMono Nerd Font",
	watermark_font_family = "poppins",
}

M.nvim_silicon = {
	font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
	theme = "Dracula",
	background = "#94e2d5",
	-- to_clipboard = true,
	output = function()
		return "~/Pictures/CodeScreenshots/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
	end,
	window_title = function()
		return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
	end,
}

return M
