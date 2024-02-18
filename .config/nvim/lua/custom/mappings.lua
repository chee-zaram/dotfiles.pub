-- Format for setting keymaps
-- ["keys"] = {"action", "description", opts = {}},

local M = {}
local opts = { silent = true, nowait = true }

M.disabled = {
	n = {
		-- Nvim chad toggle comment
		["<leader>/"] = "",
	},
}

-- Custom mapping
M.custom = {
	-- Mappings in normal mode
	n = {
		-- Tmux neovim integration
		["<C-h>"] = { "<cmd> TmuxNavigateLeft <cr>", "window left", opts = opts },
		["<C-j>"] = { "<cmd> TmuxNavigateDown <cr>", "window down", opts = opts },
		["<C-k>"] = { "<cmd> TmuxNavigateUp <cr>", "window up", opts = opts },
		["<C-l>"] = { "<cmd> TmuxNavigateRight <cr>", "window right", opts = opts },

		["<leader>w"] = { ":w<Return>", "Save current buffer", opts = opts },
		["<leader>wo"] = { ":wq<Return>", "Save current buffer and quit", opts = opts },
		["<leader>oo"] = { ":q!<Return>", "Quit the current buffer without saving", opts = opts },
		["<leader>qo"] = { ":qa!<Return>", "Quit all buffers without saving", opts = opts },
		["<leader>wq"] = { ":wqa<Return>", "Save and quit all buffers", opts = opts },

		-- Yank maps
		["x"] = { '"_x', "Delete into blackhole register", opts = opts },
		["+"] = { "<C-a>", "Increment counter", opts = opts },
		["-"] = { "<C-x>", "Decrement counter", opts = opts },
		["dw"] = { 'vb"_d', "Delete a word backwards into blackhole register", opts = opts },

		-- Tab maps
		["<leader>te"] = { ":tabedit<Return>", "Open new tab", opts = opts },
		["<leader>tn"] = { ":tabn<Return>", "Move to next tab", opts = opts },
		["<leader>tp"] = { ":tabp<Return>", "Move to previous tab", opts = opts },

		-- Split maps
		["<leader>ss"] = { ":split<Return><C-w>w", "Horizontal split and move to new split", opts = opts },
		["<leader>sv"] = { ":vsplit<Return><C-w>w", "Vertical split and move to new split", opts = opts },
		["<leader>sa"] = { "gg<S-v>G", "Select all in file", opts = opts },
		["<leader><Space>"] = { "<C-w>w", "Move to next split", opts = opts },

		["sh"] = { "<C-w>h", "Move to left split", opts = opts },
		["sk"] = { "<C-w>k", "Move to top split", opts = opts },
		["sj"] = { "<C-w>j", "Move to bottom split", opts = opts },
		["sl"] = { "<C-w>l", "Move to right split", opts = opts },
		["<leader>="] = { "<C-w>=", "Resize all splits", opts = opts },

		-- Terminal maps
		["<leader>st"] = {
			":vsplit<Return><C-w>w:terminal<Return>",
			"Start terminal in new vertical split",
			opts = opts,
		},

		-- Fugitive
		["<leader>gw"] = { ":Gwrite<Return>", "Save current buffer and git add", opts = opts },
		["<leader>gmv"] = { ":GMove", "Move current buffer with git", opts = opts },
		["<leader>gdel"] = { ":GDelete<Return>", "Delete current buffer with git rm", opts = opts },
		["<leader>grm"] = { ":GRemove<Return>", "Git rm but leaves current buffer open", opts = opts },
		["<leader>gd"] = { ":Git diff<Return>", "Bring up the file diff side by side", opts = opts },
		["<leader>gl"] = { ":G log --oneline<Return>", "Git log oneline" },
		["<leader>ga"] = { ":Git add<Return>", "Add current file to git", opts = opts },
		["<leader>gs"] = { ":G<Return>", "Status of the git repository", opts = opts },

		-- NvimTreeToggle
		["<F6>"] = { ":NvimTreeToggle<Return>", "Toggle NvimTree", opts = opts },
		["<leader>tt"] = {
			function()
				require("base46").toggle_transparency()
			end,
			"toggle transparency",
		},
	},

	-- Insert mode
	i = {
		["jk"] = { "<ESC>", "Exit insert mode", opts = opts },
		["<C-o>"] = { "<esc>viwUea", "Change word to uppercase", opts = opts },

		-- Jump to splits
		--[[ ["<leader>sh"] = { "<C-w>h", opts = opts },
    ["<leader>sk"] = { "<C-w>k", opts = opts },
    ["<leader>sj"] = { "<C-w>j", opts = opts },
    ["<leader>sl"] = { "<C-w>l", opts = opts }, ]]
	},

	-- Visual mode
	v = {
		["jk"] = { "<ESC>", "Exit insert mode", opts = opts },
	},

	-- Terminal mode
	t = {
		["<leader>jk"] = { "<C-\\><C-n>", "Exit terminal mode", opts = opts },
	},
}

M.dap = {
	plugin = true,
	n = {
		-- Go debugger
		["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Add breakpoint at line", opts = opts },
		["<leader>dus"] = {
			function()
				local widgets = require("dap.ui.widgets")
				local sidebar = widgets.sidebar(widgets.scopes)
				sidebar.open()
			end,
			"Open debugging sidebar",
			opts = opts,
		},
	},
}

M.dap_go = {
	plugin = true,
	n = {

		-- Debug nearest go test to cursor
		["<leader>dgt"] = {
			function()
				require("dap-go").debug_test()
			end,
			"Debug go test",
			opts = opts,
		},

		-- Rerun last test
		["<leader>dgl"] = {
			function()
				require("dap-go").debug_last()
			end,
			"Debug last go test",
			opts = opts,
		},
	},
}

M.gopher = {
	plugin = true,

	n = {
		["<leader>gsj"] = { "<cmd> GoTagAdd json <CR>", "Add json struct tags", opts = opts },
		["<leader>gsy"] = { "<cmd> GoTagAdd yaml <CR>", "Add yaml struct tags", opts = opts },
	},
}

M.todo = {
	plugin = true,

	n = {
		["<leader>ft"] = { "<cmd> TodoTelescope <CR>", "Open todo list in telescope", opts = opts },
	},
}

M.trouble = {
	plugin = true,

	n = {
		["<leader>tr"] = { "<cmd> TroubleToggle <CR>", "See all diagonstic troubles ", opts = opts },
	},
}

M.lspsaga = {
	-- plugin = true,

	n = {
		["<C-j>"] = { "<CMD> Lspsaga diagnostic_jump_next <CR>", "Go to next error", opts = opts },
		["K"] = { "<CMD> Lspsaga hover_doc <CR>", "Get documentation", opts = opts },
		["<leader>f"] = { "<Cmd>Lspsaga finder<CR>", "Find identifier references", opts = opts },
		["ca"] = { "<Cmd>Lspsaga code_action<CR>", "Show available code actions", opts = opts },
		["gd"] = { "<Cmd>Lspsaga goto_definition<CR>", "Go to definition", opts = opts },
		["<leader>pd"] = { "<Cmd>Lspsaga peek_definition<CR>", "Peek definition", opts = opts },
		["gr"] = { "<Cmd>Lspsaga rename<CR>", "Rename identifier", opts = opts },
	},

	i = {
		["<C-k"] = { "<Cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help", opts = opts },
	},
}

return M
