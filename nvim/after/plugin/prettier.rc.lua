local status, prettier = pcall(require, 'prettier')
if (not status) then return end

prettier.setup({
	bin = 'prettierd',
	filetypes = {
		'c',
		'python',
		'css',
		'javascript',
		'javascriptreact',
		'typescript',
		'typescriptreact',
		'json',
		'scss',
		'rust',
		'less'
	}
})
