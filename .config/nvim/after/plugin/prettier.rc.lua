local status, prettier = pcall(require, 'prettier')
if (not status) then return end

prettier.setup({
    bin = 'prettier',
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
