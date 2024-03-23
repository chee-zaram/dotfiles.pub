local ok, conform = pcall(require, "conform")
if not ok then return end

local options = {
  formatters_by_ft = {
    c = { "clang-format" },
    go = { "gofumpt", "golines" },
    javascript = { { "prettierd", "prettier" } },
    json = { "biome" },
    lua = { "stylua" },
    markdown = { "prettier" },
    sh = { "shfmt" },
    typescript = { "prettier" },
    yaml = { "prettier" },
  },

  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },

  formatters = {
    shfmt = {
      prepend_args = { "-i", "2", "-ci", "-bn" },
    },
  },
}

vim.keymap.set("n", "<leader>sp", function()
  conform.format({
    formatters = {
      "codespell",
    },
  })
end)

conform.setup(options)
