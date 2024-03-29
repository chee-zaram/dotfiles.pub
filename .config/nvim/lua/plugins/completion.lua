local cmp_opts = {
  sources = {
    { name = "codeium" },
  },

  experimental = {
    ghost_text = true,
  },
}

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      opts = { history = true, updateevents = "TextChanged,TextChangedI" },
      config = function(_, opts)
        require("luasnip").config.set_config(opts)
        require "nvchad.configs.luasnip"
      end,
    },

    {
      "windwp/nvim-autopairs",
      opts = {
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
      },
      config = function(_, opts)
        require("nvim-autopairs").setup(opts)

        -- setup cmp for autopairs
        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        require("cmp").event:on(
          "confirm_done",
          cmp_autopairs.on_confirm_done()
        )
      end,
    },

    -- cmp sources plugins
    {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },

    {
      "jcdickinson/codeium.nvim",
      config = function()
        require("codeium").setup {}
      end,
    },

  },

  opts = function()
    local opts = require("nvchad.configs.cmp")
    table.insert(opts.sources, cmp_opts.sources[1])
    opts.experimental = cmp_opts.experimental
    return opts
  end,
}
