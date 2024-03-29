return {
  -- Make sure to install to your system all the fonts specified
  -- in your overrides as well as the silicon binary using your os package
  -- manager.
  {
    "michaelrommel/nvim-silicon",
    cmd = "Silicon",
    opts = {
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
    },
  },
}
