local M = {}

M.treesitter = {
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
}

local mason_ensure_installed = {
  -- Web dev
  "css-lsp",
  "html-lsp",
  "htmx-lsp",
  "typescript-language-server",
  "prettier",
  "tailwindcss-language-server",

  -- C
  "clangd",
  "clang-format",

  -- Lua
  "lua-language-server",
  -- "stylua",

  -- Go
  "gopls",
  "gofumpt",
  "golines",
  "templ",

  -- Python
  -- "python-lsp-server",
  "debugpy",
  "pyright",
  "ruff-lsp",
  "mypy",

  -- Shell
  "bash-language-server",
  "shfmt",

  -- Rust
  "rust-analyzer",

  -- Configuration
  "yaml-language-server",
  "dockerfile-language-server",
  "terraform-ls",
  "taplo",
}

M.mason = {
  ensure_installed = mason_ensure_installed,
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
}

M.mason_installer = {
  ensure_installed = mason_ensure_installed,
  auto_update = true,
}

M.cmp = {
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "codeium" },
  },

  experimental = {
    ghost_text = true,
  },
}

M.saga = {
  server_filetype_map = {},
}

M.nvim_silicon = {
  font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
  theme = "Dracula",
  background = "#94e2d5",
  -- to_clipboard = true,
  output = function()
    return "~/Pictures/CodeScreenshots/" .. os.date "!%Y-%m-%dT%H-%M-%S" .. "_code.png"
  end,
  window_title = function()
    return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
  end,
}

M.noice = {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    hover = { enabled = false },
    signature = { enabled = false },
  },
  presets = {
    bottom_search = false,        -- use a classic bottom cmdline for search
    command_palette = false,      -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
  routes = {
    {
      filter = {
        event = 'msg_show',
        any = {
          { find = '%d+L, %d+B' },
          { find = '; after #%d+' },
          { find = '; before #%d+' },
          { find = '%d fewer lines' },
          { find = '%d more lines' },
        },
      },
    }
  },
}

M.blankline = {
  scope = {
    enabled = false,
  },
}

return M
