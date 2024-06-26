local ok, neogit = pcall(require, "neogit")
if not ok then return end

neogit.setup({
  integrations = {
    diffview = true,
  },

  kind = "split",
})

local map = vim.keymap.set
local opts = { silent = true }

map(
  "n",
  "<leader>go",
  neogit.open,
  vim.tbl_extend("keep", { desc = "Neogit Status of the git repository" }, opts)
)

map(
  "n",
  "<leader>gs",
  function()
    neogit.open { kind = "auto" }
  end,
  vim.tbl_extend("keep", { desc = "Neogit Status in split" }, opts)
)

map(
  "n",
  "<leader>gc",
  function()
    neogit.open { "commit" }
  end
)

map(
  "n",
  "<leader>gl",
  function()
    neogit.open { "log" }
  end
)

map(
  "n",
  "<leader>dv",
  "<CMD>DiffviewOpen<CR>",
  opts
)

map(
  "n",
  "<leader>dc",
  "<CMD>DiffviewClose<CR>",
  opts
)
