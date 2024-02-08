local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local servers = {
	"html",
	"cssls",
	"clangd",
	"gopls",
	"pylsp",
	"yamlls",
	"tsserver",
	"htmx",
	-- "bash-language-server",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.pylsp.setup({ filetypes = { "python" } })

lspconfig.yamlls.setup({
	format = {
		enable = true,
	},
})

lspconfig.tsserver.setup({
	filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascript.js" },
	cmd = { "typescript-language-server", "--stdio" },
})

lspconfig.gopls.setup({
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
})

-- For the bash language serve
vim.api.nvim_create_autocmd("FileType", {
	pattern = "sh",
	callback = function()
		vim.lsp.start({
			name = "bash-language-server",
			cmd = { "bash-language-server", "start" },
		})
	end,
})
