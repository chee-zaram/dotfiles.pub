local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    -- python = { "isort", "black" },
    -- python = { "autopep8" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettierd", "prettier" } },

    typescript = { "prettier" },

    go = { "gofumpt", "golines" },

    c = { "clang-format" },

    markdown = { "prettier" },

    yaml = { "prettier" },
  },

  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
}

require("conform").setup(options)
