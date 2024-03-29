return {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(_, opts)
      require("trouble").setup(opts)
    end,
  },
}
