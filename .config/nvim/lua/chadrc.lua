local M = {}

M.ui = {
  theme = "tokyonight",

  hl_override = {
    ["@comment"] = { italic = true },
    ["@keyword.conditional"] = { italic = true },
    ["@keyword.conditional.ternary"] = { italic = true },

    Include = { italic = true, },
  },
}

return M
