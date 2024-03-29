return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "glepnir/lspsaga.nvim",
      branch = "main",
      opts = {
        server_filetype_map = {},
      },
    },

    {
      "nvimtools/none-ls.nvim",
      opts = function()
        return require "configs.null-ls"
      end,
    },

    { "folke/neodev.nvim" },
    { "j-hui/fidget.nvim" },
  },

  config = function()
    require("nvchad.configs.lspconfig").defaults()
    require("configs.lspconfig")
  end,
}
