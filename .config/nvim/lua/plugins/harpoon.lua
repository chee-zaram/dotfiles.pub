-- NOTE: Marks
return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  branch = "harpoon2",
  config = function(_, _)
    require "configs.my-harpoon"
  end,
  keys = function()
    local harpoon = require "harpoon"

    local keys = {
      {
        "<leader>a",
        function()
          harpoon:list():append()
        end,
        desc = "Harpoon Add File",
      },
      {
        "<leader>h",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
      {
        "]h",
        function()
          harpoon:list():next()
        end,
        desc = "Harpoon Next file",
      },
      {
        "[h",
        function()
          harpoon:list():prev()
        end,
        desc = "Harpoon Previous file",
      }
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon Goto File " .. i,
      })
    end
    return keys
  end
}
