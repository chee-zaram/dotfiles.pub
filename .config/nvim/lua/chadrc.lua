---@type ChadrcConfig
local M = {}

M.ui = {
  -- theme = "tokyonight",
  theme = "mountain",

  hl_override = {
    ["@comment"] = { italic = true },
    ["@number"] = { italic = true },
    ["@keyword.conditional"] = { italic = true },
    ["@keyword.conditional.ternary"] = { italic = true },

    Include = { italic = true, },
  },
}

return M
