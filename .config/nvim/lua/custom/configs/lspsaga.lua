local status, saga = pcall(require, "lspsaga")
if not status then
	return
end
saga.setup({ server_filetype_map = {} })

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "[e", "<Cmd>Lspsaga diagnostic_jump_next<cr>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "<leader>f", "<Cmd>Lspsaga finder<CR>", opts)
vim.keymap.set("n", "ca", "<Cmd>Lspsaga code_action<CR>", opts)
-- vim.keymap.set({ "n", "t", "<A-d>", "<cmd>Lspsaga term_toggle" })
vim.keymap.set("n", "gd", "<Cmd>Lspsaga goto_definition<CR>", opts)
vim.keymap.set("i", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
vim.keymap.set("n", "<leader>pd", "<Cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
