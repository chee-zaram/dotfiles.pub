require "nvchad.mappings"

local map = vim.keymap.set
local opts = { silent = true }

-- Manipulating buffer
map(
  "n",
  "<leader>w",
  ":w<Return>",
  vim.tbl_extend("keep", { desc = "Base Write current buffer" }, opts)
)
map(
  "n",
  "<leader>wo",
  ":wq<Return>",
  vim.tbl_extend("keep", { desc = "Base Write current buffer and quit" }, opts)
)
map(
  "n",
  "<leader>oo",
  ":q!<Return>",
  vim.tbl_extend(
    "keep",
    { desc = "Base Close the current buffer without saving" },
    opts
  )
)
map(
  "n",
  "<leader>qo",
  ":qa!<Return>",
  vim.tbl_extend("keep", { desc = "Base All buffers without saving" }, opts)
)
map(
  "n",
  "<leader>wq",
  ":wqa<Return>",
  vim.tbl_extend("keep", { desc = "Base Write and quit all buffers" }, opts)
)
map(
  "n",
  "x",
  '"_x',
  vim.tbl_extend("keep", { desc = "Base Delete character(s) under cursor to blackhole register" }, opts)
)
map(
  "n",
  "+",
  "<C-a>",
  vim.tbl_extend("keep", { desc = "Base Increment counter" }, opts)
)
map(
  "n",
  "-",
  "<C-x>",
  vim.tbl_extend("keep", { desc = "Base Decrement counter" }, opts)
)
map(
  "n",
  "dw",
  'vb"_d',
  vim.tbl_extend(
    "keep",
    { desc = "Base Delete a word backwards into blackhole register" },
    opts
  )
)
map(
  { "i", "v" },
  "jk",
  "<ESC>",
  vim.tbl_extend("keep", { desc = "Base Exit current mode" }, opts)
)
map(
  "i",
  "<C-o>",
  "<esc>viwUea",
  vim.tbl_extend("keep", { desc = "Base Change word to uppercase" }, opts)
)
map(
  "t",
  "<leader>jk",
  "<C-\\><C-n>",
  vim.tbl_extend("keep", { desc = "Base Exit terminal mode" }, opts)
)
map(
  "n",
  "<leader>te",
  ":tabedit<Return>",
  vim.tbl_extend("keep", { desc = "Base Open new tab" }, opts)
)
map(
  "n",
  "<leader>tn",
  ":tabn<Return>",
  vim.tbl_extend("keep", { desc = "Base Move to next tab" }, opts)
)
map(
  "n",
  "<leader>tp",
  ":tabp<Return>",
  vim.tbl_extend("keep", { desc = "Base Move to previous tab" }, opts)
)
map(
  "n",
  "<leader>sh",
  ":split<Return><C-w>w",
  vim.tbl_extend(
    "keep",
    { desc = "Base Horizontal split and move to new split" },
    opts
  )
)
map(
  "n",
  "<leader>sv",
  ":vsplit<Return><C-w>w",
  vim.tbl_extend(
    "keep",
    { desc = "Base Vertical split and move to new split" },
    opts
  )
)
map(
  "n",
  "<leader>=",
  "<C-w>=",
  vim.tbl_extend("keep", { desc = "Base Resize all splits" }, opts)
)
map(
  "n",
  "<leader><Space>",
  "<C-w>w",
  vim.tbl_extend("keep", { desc = "Base Move to next split" }, opts)
)
map(
  "n",
  "<leader>st",
  ":vsplit<Return><C-w>w:terminal<Return>",
  vim.tbl_extend(
    "keep",
    { desc = "Base Start terminal in new vertical split" },
    opts
  )
)
map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end, vim.tbl_extend("keep", { desc = "Base Toggle Transparency" }, opts))

-- Fugitive
map(
  "n",
  "<leader>gw",
  ":Gwrite<Return>",
  vim.tbl_extend("keep", { desc = "Fugitive Save current buffer and git add" }, opts)
)
map(
  "n",
  "<leader>gmv",
  ":GMove",
  vim.tbl_extend("keep", { desc = "Fugitive Move current buffer with git" }, opts)
)
map(
  "n",
  "<leader>gdel",
  ":GDelete<Return>",
  vim.tbl_extend("keep", { desc = "Fugitive Delete current buffer with git rm" }, opts)
)
map(
  "n",
  "<leader>grm",
  ":GRemove<Return>",
  vim.tbl_extend(
    "keep",
    { desc = "Fugitive Git rm but leaves current buffer open" },
    opts
  )
)
map(
  "n",
  "<leader>gd",
  ":Git diff<Return>",
  vim.tbl_extend("keep", { desc = "Fugitive Bring up the file diff side by side" }, opts)
)
map(
  "n",
  "<leader>gl",
  ":G log --oneline<Return>",
  vim.tbl_extend("keep", { desc = "Fugitive Git log oneline" }, opts)
)
map(
  "n",
  "<leader>ga",
  ":Git add<Return>",
  vim.tbl_extend("keep", { desc = "Fugitive Add current file to git" }, opts)
)
map(
  "n",
  "<leader>gs",
  ":G<Return>",
  vim.tbl_extend("keep", { desc = "Fugitive Status of the git repository" }, opts)
)

-- NvimTreeToggle
map(
  "n",
  "<F6>",
  ":NvimTreeToggle<Return>",
  vim.tbl_extend("keep", { desc = "NvimTree Toggle NvimTree" }, opts)
)

-- TMUX
map(
  "n",
  "<C-h>",
  "<cmd> TmuxNavigateLeft <cr>",
  vim.tbl_extend("keep", { desc = "TMUX Window left" }, opts)
)
map(
  "n",
  "<C-j>",
  "<cmd> TmuxNavigateDown <cr>",
  vim.tbl_extend("keep", { desc = "TMUX Window down" }, opts)
)
map(
  "n",
  "<C-k>",
  "<cmd> TmuxNavigateUp <cr>",
  vim.tbl_extend("keep", { desc = "TMUX Window up" }, opts)
)
map(
  "n",
  "<C-l>",
  "<cmd> TmuxNavigateRight <cr>",
  vim.tbl_extend("keep", { desc = "TMUX Window right" }, opts)
)

-- Debugging
map(
  "n",
  "<leader>db",
  "<cmd> DapToggleBreakpoint <CR>",
  vim.tbl_extend("keep", { desc = "Dap Add breakpoint at line" }, opts)
)
map(
  "n",
  "<leader>so",
  "<CMD> DapStepOver <CR>",
  vim.tbl_extend("keep", { desc = "Dap Step over the breakpoint" }, opts)
)
map("n", "<leader>dui", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, vim.tbl_extend("keep", { desc = "Dap Open debugging ui" }, opts))

map("n", "<leader>dgt", function()
  require("dap-go").debug_test()
end, vim.tbl_extend("keep", { desc = "Go Debug Go test" }, opts))

-- Rerun last test
map("n", "<leader>dgl", function()
  require("dap-go").debug_last()
end, vim.tbl_extend("keep", { desc = "Go Debug last go test" }, opts))

map(
  "n",
  "<leader>dpm",
  function()
    require("dap-python").test_method()
  end,
  vim.tbl_extend(
    "keep",
    { desc = "Python Debug Python Test method under cursor" },
    opts
  )
)
map(
  "n",
  "<leader>dpc",
  function()
    require("dap-python").test_class()
  end,
  vim.tbl_extend(
    "keep",
    { desc = "Python Debug Python Test class under cursor" },
    opts
  )
)

-- Gopher
map(
  "n",
  "<leader>gsj",
  "<cmd> GoTagAdd json <CR>",
  vim.tbl_extend("keep", { desc = "Go Add JSON struct tags" }, opts)
)
map(
  "n",
  "<leader>gsy",
  "<cmd> GoTagAdd yaml <CR>",
  vim.tbl_extend("keep", { desc = "Go Add YAML struct tags" }, opts)
)
map(
  "n",
  "<leader>gmt",
  "<cmd> GoMod tidy <CR>",
  vim.tbl_extend("keep", { desc = "Go Run go mod tidy" }, opts)
)
map(
  "n",
  "<leader>gtadd",
  "<cmd> GoTestAdd <CR>",
  vim.tbl_extend(
    "keep",
    { desc = "Go Add test for the func under the cursor" },
    opts
  )
)
map(
  "n",
  "<leader>gtall",
  "<cmd> GoTestsAll <CR>",
  vim.tbl_extend("keep", { desc = "Go Add tests for all functions in file" }, opts)
)

-- Todo
map(
  "n",
  "<leader>ft",
  "<cmd> TodoTelescope <CR>",
  vim.tbl_extend("keep", { desc = "TODO Open todo list in telescope" }, opts)
)

-- Trouble
map(
  "n",
  "<leader>tr",
  "<cmd> TroubleToggle <CR>",
  vim.tbl_extend("keep", { desc = "Trouble See all diagonstic troubles " }, opts)
)

-- LSP Saga
map(
  "n",
  "<C-n>",
  "<CMD> Lspsaga diagnostic_jump_next <CR>",
  vim.tbl_extend("keep", { desc = "LSPSaga Go to next error" }, opts)
)
map(
  "n",
  "K",
  "<CMD> Lspsaga hover_doc <CR>",
  vim.tbl_extend("keep", { desc = "LSPSaga Get documentation" }, opts)
)
map(
  "n",
  "<leader>f",
  "<Cmd>Lspsaga finder<CR>",
  vim.tbl_extend("keep", { desc = "LSPSaga Find identifier references" }, opts)
)
map(
  "n",
  "ca",
  "<Cmd>Lspsaga code_action<CR>",
  vim.tbl_extend("keep", { desc = "LSPSaga Show available code actions" }, opts)
)
map(
  "n",
  "gd",
  "<Cmd>Lspsaga goto_definition<CR>",
  vim.tbl_extend("keep", { desc = "LSPSaga Go to definition" }, opts)
)
map(
  "n",
  "<leader>pd",
  "<Cmd>Lspsaga peek_definition<CR>",
  vim.tbl_extend("keep", { desc = "LSPSaga Peek definition" }, opts)
)
map(
  "n",
  "<leader>rn",
  "<Cmd>Lspsaga rename<CR>",
  vim.tbl_extend("keep", { desc = "LSPSaga Rename identifier" }, opts)
)

-- Crates
map("n", "<leader>rcu", function()
  require("crates").upgrade_all_crates()
end, vim.tbl_extend("keep", { desc = "Crates Update crates" }, opts))

-- Obsession
map(
  "n",
  "<leader>ss",
  "<CMD>Obsession .<CR>",
  vim.tbl_extend(
    "keep",
    { desc = "Obsession Save session file in current directory" },
    opts
  )
)

-- Nvim Silicon
map(
  "v",
  "<leader>sc",
  ":Silicon <CR> ",
  vim.tbl_extend("keep", { desc = "NVIM-Silicon Screenshot Code" }, opts)
)
