return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gwrite", "GMove", "GDelete", "GRemove" },
  config = function()
    require "configs.fugitive"
  end,
}
