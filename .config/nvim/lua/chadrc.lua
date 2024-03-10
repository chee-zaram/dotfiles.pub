local M = {}

-- Path to overriding themes
local highlights = require "highlights"

M.ui = {
  theme = "catppuccin",

  hl_override = {
    ["@comment"] = { italic = true },
    ["@keyword.conditional"] = { italic = true },
    ["@keyword.conditional.ternary"] = { italic = true },
  },

  hl_add = highlights.add,
}

return M
