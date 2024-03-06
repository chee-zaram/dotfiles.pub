local options = require("custom.overrides")

local plugins = {

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
          return require("custom.configs.null-ls")
        end,
      },
    },

    config = function()
      require("custom.configs.lspconfig")
    end,
  },

  "folke/neodev.nvim",

  {
    "nvim-treesitter/nvim-treesitter",
    opts = options.treesitter,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = options.mason,
      },
    },
    opts = options.mason_installer,
  },

  {
    lazy = false,
    "stevearc/conform.nvim",
    opts = options.conform,
  },

  {
    "tpope/vim-fugitive", -- Use git commands from within neovim
    lazy = false,
    config = function()
      require("custom.configs.fugitive")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = options.treesitter,
  },

  { "nvim-treesitter/nvim-treesitter-context", lazy = false },

  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = function()
      require("plugins.configs.telescope")
      require("custom.configs.telescope")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
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
    },
    opts = function()
      local opts = require("plugins.configs.cmp")
      opts.sources = options.cmp.sources
      return opts
    end,

    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  -- Debugger
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    init = function()
      require("core.utils").load_mappings("dap")
    end,
  },

  -- Go Debugger to work with nvim-dap
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
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
      require("core.utils").load_mappings("dap_python")
    end,
  },

  -- Go extras
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
  },

  {
    "folke/todo-comments.nvim",
    cmd = "TodoTelescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      require("todo-comments").setup(opts)
      require("core.utils").load_mappings("todo")
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(_, opts)
      require("trouble").setup(opts)
      require("core.utils").load_mappings("trouble")
    end,
  },

  {
    "jcdickinson/codeium.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    keys = { "<C-j>", "<C-k>", "<C-l>", "<C-h>" },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
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
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
      require("core.utils").load_mappings("crates")
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

  {
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = "CodeSnapPreviewOn",
    opts = options.code_snap_preview,
    config = function(_, opts)
      require("codesnap").setup(opts)
    end,
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
}

return plugins
