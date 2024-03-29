return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = { "<leader>gs", "<leader>gc", "<leader>gll" },
    config = function(_, _)
      require "configs.git"
    end
  },
}
