return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-context" },
  },

  opts = {
    highlight = {
      enable = true,
      disable = {},
    },

    indent = {
      enable = true,
      disable = {},
    },

    ensure_installed = {
      -- defaults
      "vim",
      "vimdoc",
      "lua",
      "comment",
      "gitcommit",
      "json",
      "yaml",
      "toml",

      -- web dev
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "markdown",
      "markdown_inline",
      "python",
      "go",
      "bash",
      "templ",

      -- low level
      "c",
      "zig",
      "rust",
    },

    autotag = {
      enable = true,
    },
  },
}
