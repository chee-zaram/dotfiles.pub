local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup({
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    ensure_installed = {
        'tsx',
        'html',
        'http',
        'regex',
        'lua',
        'json',
        'css',
        'comment',
        'c',
        'bash',
        'python',
        'rust',
        'java',
        'javascript',
        'go',
        'gitcommit',
        -- 'gitignore',
        'git_rebase',
        'gitattributes',
        'markdown',
        'markdown_inline',
        'make',
        'php',
        'ruby',
    },
    autotag = {
        enable = true,
    }
})
