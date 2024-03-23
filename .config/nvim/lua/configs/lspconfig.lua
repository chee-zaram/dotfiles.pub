local configs = require "nvchad.configs.lspconfig"
local on_attach = configs.on_attach
local capabilities = configs.capabilities
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local servers = {
  html = {
    filetypes = { "html" },
  },

  cssls = {
  },

  clangd = {
    on_attach = function(client, bufnr)
      client.server_capabilities.signatureHelpProvider = false
      on_attach(client, bufnr)
    end,
    capabilities = (function()
      capabilities.offsetEncoding = { "utf-16" }
      return capabilities
    end)(),
  },

  gopls = {
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
  },

  basedpyright = {
    filetypes = { "python" },
    settings = {
      basedpyright = {
        typeCheckingMode = "standard",
      },
    },
  },

  ruff_lsp = {
    filetypes = { "python" },
  },

  yamlls = {
    format = {
      enable = true,
    },
  },

  tsserver = {
    filetypes = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "javascript",
      "javascript.js",
    },
    cmd = { "typescript-language-server", "--stdio" },
  },

  htmx = {
    filetypes = { "html" },
  },

  dockerls = {
  },

  bashls = {
  },

  tailwindcss = {
    filetypes = { "astro", "javascript", "typescript", "react" },
  },

  rust_analyzer = {
  },

  terraformls = {
    filetypes = { "terraform" },
    cmd = { "terraform-ls", "serve" },
    root_dir = util.root_pattern(".terraform", ".git"),
  },

  taplo = {
  },

  templ = {
    -- Make sure to install the templ cli.
    filetypes = { "templ" },
  },
}

local generic_config = {
  on_attach = on_attach,
  capabilities = capabilities,
}

for server_name, server_config in pairs(servers) do
  server_config = vim.tbl_deep_extend("force", generic_config, server_config)
  lspconfig[server_name].setup(server_config)
end
