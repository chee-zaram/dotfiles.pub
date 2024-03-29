local ensure_installed = {
  -- Generic
  "codespell",

  -- Web dev
  "css-lsp",
  "html-lsp",
  "htmx-lsp",
  "typescript-language-server",
  "prettier",
  "tailwindcss-language-server",
  "biome",

  -- C
  "clangd",
  "clang-format",

  -- Lua
  "lua-language-server",
  -- "stylua",

  -- Go
  "gopls",
  "gofumpt",
  "golines",
  "templ",

  -- Python
  "debugpy",
  "basedpyright",
  "ruff-lsp",
  "mypy",

  -- Shell
  "bash-language-server",
  "shfmt",

  -- Rust
  "rust-analyzer",

  -- Configuration
  "yaml-language-server",
  "dockerfile-language-server",
  "terraform-ls",
  "taplo",
}

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  event = "BufReadPost",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = ensure_installed,
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
    },
  },

  opts = {
    ensure_installed = ensure_installed,
    auto_update = true,
  },
}
