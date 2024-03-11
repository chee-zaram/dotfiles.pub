local status, telescope = pcall(require, "telescope")
if not status then
  return
end
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local themes = require "telescope.themes"

local fb_actions = require("telescope").extensions.file_browser.actions

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

telescope.load_extension "file_browser"

-- Find files in the project by searching
vim.keymap.set("n", ";f", function()
  builtin.find_files {
    no_ignore = false,
    hidden = true,
  }
end)

-- Do live grep of all string in project
vim.keymap.set("n", ";r", function()
  builtin.live_grep()
end)

-- See a list of current buffers
vim.keymap.set("n", "\\\\", function()
  builtin.buffers()
end)

-- Display help tags
vim.keymap.set("n", ";t", function()
  builtin.help_tags()
end)

-- Resume to last spot in telescope
vim.keymap.set("n", ";;", function()
  builtin.resume()
end)

-- View diagnostics
vim.keymap.set("n", ";e", function()
  builtin.diagnostics()
end)

-- File browser
vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser {
    path = "%:p:h",
    -- cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    -- previewer = false,
    initial_mode = "normal",
    -- layout_config = { height = 40 },
  }
end, { noremap = true })

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
  { desc = "Search current word" }
)

vim.keymap.set(
  "n",
  "<leader>ds",
  builtin.lsp_document_symbols,
  { desc = "Symbols in the current document" }
)

vim.keymap.set(
  "n",
  "<leader>ws",
  builtin.lsp_dynamic_workspace_symbols,
  { desc = "Symbols across entire project" }
)
