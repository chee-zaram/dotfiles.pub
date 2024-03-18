local ok, wezterm = pcall(require, 'wezterm')
if not ok then return end

return {
  -- color_scheme = 'Catppuccin Mocha',
  color_scheme = 'Oxocarbon Dark (Gogh)',
  enable_tab_bar = false,
  font_size = 12.0,
  window_background_opacity = 1.0,
  window_decorations = 'RESIZE',
  mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}
