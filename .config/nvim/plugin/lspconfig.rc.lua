-- LSP configuration
local status, protocol = pcall(require, 'vim.lsp.protocol')
if (not status) then return end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
        end,
    })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mapping options
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
end

protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
}


-- You can uncomment any of the LSPs below to autoinstall it
-- Just close neovim and open again
-- Alternatively, you could use the :Mason command to see a list of LPSs you
-- can install, and click i on anyone to install it. You may need dependencies
-- for some.
--
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pylsp = {},
    -- rust_analyzer = {
    --     settings = {
    --         ["rust-analyzer"] = {
    --             imports = {
    --                 granularity = {
    --                     group = "module",
    --                 },
    --                 prefix = "self",
    --             },
    --             cargo = {
    --                 buildScripts = {
    --                     enable = true,
    --                 },
    --             },
    --             procMacro = {
    --                 enable = true
    --             },
    --             checkOnSave = {
    --                 command = "clippy",
    --             },
    --         }
    --     }
    -- },
    -- tsserver = {
    --     filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascript.js" },
    --     cmd = { "typescript-language-server", "--stdio" }
    -- },
    -- lua_ls = {
    --     settings = {
    --         Lua = {
    --             diagnostics = {
    --                 -- Get the language server to recognize the 'vim' global
    --                 global = { 'vim' }
    --             },
    --
    --             workspace = {
    --                 -- Make the server aware of Neovim runtime files
    --                 library = vim.api.nvim_get_runtime_file("", true),
    --                 checkThirdParty = false,
    --             },
    --             telemetry = { enable = false },
    --         },
    --     },
    -- },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
local status1, mason = pcall(require, "mason")
if (not status1) then return end

local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            enable_format_on_save(_, bufnr),
            settings = servers[server_name],
        }
    end,
}

-- For the bash language serve
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'sh',
    callback = function()
        vim.lsp.start({
            name = 'bash-language-server',
            cmd = { 'bash-language-server', 'start' },
        })
    end,
})
