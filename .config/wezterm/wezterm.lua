local ok, wezterm = pcall(require, 'wezterm')
if not ok then return end

return {
  color_scheme = 'Oxocarbon Dark (Gogh)',
  enable_tab_bar = false,
  font_size = 14.0,
  font = wezterm.font('JetBrainsMono Nerd Font'),
  window_background_opacity = 1.0,
  window_decorations = 'RESIZE',
  warn_about_missing_glyphs = false,
  mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}
