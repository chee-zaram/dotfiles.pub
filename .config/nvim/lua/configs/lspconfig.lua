require("neodev").setup({})
local configs = require "nvchad.configs.lspconfig"
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local servers = {
  "html",
  "cssls",
  "clangd",
  "gopls",
  -- "pylsp",
  "pyright",
  "ruff_lsp",
  "yamlls",
  "tsserver",
  "htmx",
  "dockerls",
  "bashls",
  "tailwindcss",
  "rust_analyzer",
  "terraformls",
  "taplo",
  "templ",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- lspconfig.pylsp.setup({ filetypes = { "python" } })
lspconfig.pyright.setup { filetypes = { "python" } }
lspconfig.ruff_lsp.setup { filetypes = { "python" } }

lspconfig.yamlls.setup {
  format = {
    enable = true,
  },
}

lspconfig.tsserver.setup {
  filetypes = {
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "javascript",
    "javascript.js",
  },
  cmd = { "typescript-language-server", "--stdio" },
}

lspconfig.gopls.setup {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  cmd_env = {
    GOFLAGS = "-tags=test,e2e_test,integration_test,acceptance_test",
  },
  settings = {
    gopls = {
      gofumpt = true,
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.terraformls.setup {
  filetypes = { "terraform" },
  cmd = { "terraform-ls", "serve" },
  root_dir = util.root_pattern(".terraform", ".git"),
}

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = (function()
    capabilities.offsetEncoding = { "utf-16" }
    return capabilities
  end)(),
}

-- Make sure to install the templ cli.
lspconfig.templ.setup {
  filetypes = { "templ" },
}

lspconfig.html.setup {
  filetypes = { "html" },
}

lspconfig.tailwindcss.setup {
  filetypes = { "astro", "javascript", "typescript", "react" },
  -- init_options = { userLanguages = { templ = "html" } },
}

lspconfig.htmx.setup {
  filetypes = { "html" },
}
