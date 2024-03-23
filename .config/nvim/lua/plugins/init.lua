local options = require "overrides"

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
    },
  },

  -- Get preview of markdown files as you type
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "glepnir/lspsaga.nvim",
        branch = "main",
        opts = options.saga,
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
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "BufReadPost",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = options.mason,
      },
    },
    opts = options.mason_installer,
  },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gwrite", "GMove", "GDelete", "GRemove" },
    config = function()
      require "configs.fugitive"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context" },
    },
    opts = options.treesitter,
  },

  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    config = function()
      require "nvchad.configs.telescope"
      require "configs.telescope"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
  },

  {
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
      return vim.tbl_deep_extend("force", require("nvchad.configs.cmp"), options.cmp)
    end,
  },

  -- Debugger
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
  },

  -- Go Debugger to work with nvim-dap
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, _)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },

  -- Go extras
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },

  {
    "folke/todo-comments.nvim",
    cmd = "TodoTelescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      require("todo-comments").setup(opts)
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(_, opts)
      require("trouble").setup(opts)
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateRight", "TmuxNavigateUp", "TmuxNavigateDown" },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("configs.dapui")
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "tpope/vim-obsession",
    cmd = "Obsession",
  },

  -- Make sure to install to your system all the fonts specified
  -- in your overrides as well as the silicon binary using your os package
  -- manager.
  {
    "michaelrommel/nvim-silicon",
    cmd = "Silicon",
    config = function()
      require("silicon").setup(options.nvim_silicon)
    end,
  },

  {
    "cappyzawa/trim.nvim",
    event = "VeryLazy",
    opts = {
      ft_blocklist = { "markdown" },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = options.blankline,
  },

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

  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        enabled = false,
      })
    end
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = options.noice,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },

  { "ray-x/go.nvim",         ft = "go" },
  { "tjdevries/cyclist.vim", lazy = false },

  {
    'IogaMaster/neocord',
    event = "VeryLazy",
    config = {
      main_image = "logo",
      logo = "https://0x0.st/H3Rh.png",
      log_level = "error",
    },
  },

  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "VeryLazy",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "dashboard",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
