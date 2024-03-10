-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

M.override = {
  ["@comment"] = { italic = true },
  ["@conditional"] = { italic = true },
  ["@identifier"] = { italic = true },
  ["@type.builtin"] = { bold = false },
  ["@keyword.conditional"] = { italic = true },
}

M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
