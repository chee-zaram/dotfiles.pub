local status, telescope = pcall(require, "telescope")
if not status then
  return
end
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local themes = require "telescope.themes"
local fb_actions = require("telescope").extensions.file_browser.actions

pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")
pcall(telescope.load_extension, "file_browser")

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables network add use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function()
            vim.cmd "normal vbd"
          end,
        },
        ["n"] = {
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd "startinsert"
          end,
        },
      },
    },
  },
}

-- Resume to last spot in telescope
vim.keymap.set("n", ";;", function()
  builtin.resume()
end)

-- View diagnostics
vim.keymap.set("n", ";e", function()
  builtin.diagnostics()
end)

-- Fuzzily find in the current buffer
vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find(themes.get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set(
  "n",
  "<leader>sw",
  builtin.grep_string,
  { desc = "Telescope Search current word" }
)

vim.keymap.set(
  "n",
  "<leader>ds",
  builtin.lsp_document_symbols,
  { desc = "Telescope Symbols in the current document" }
)

vim.keymap.set(
  "n",
  "<leader>ws",
  builtin.lsp_dynamic_workspace_symbols,
  { desc = "Telescope Symbols across entire project" }
)

vim.keymap.set(
  "n",
  "<leader>gbr",
  "<CMD>Telescope git_branches<CR>",
  { desc = "Telescope Symbols across entire project" }
)

vim.keymap.set(
  "n",
  "<leader>sm",
  "<cmd>Telescope marks<cr>",
  { desc = "Telescope Jump to Mark" }
)

vim.keymap.set(
  "n",
  "<leader>sM",
  "<cmd>Telescope man_pages<cr>",
  { desc = "Telescope Man Pages" }
)

vim.keymap.set(
  "n", '<leader>s"',
  "<cmd>Telescope registers<cr>",
  { desc = "Telescope Registers" }
)
