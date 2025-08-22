-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- nid configs
config.color_scheme = "Gruvbox Dark (Gogh)"
config.initial_cols = 120
config.initial_rows = 28

-- that sweet acrylic bg
-- config.window_background_opacity = 0.8
-- config.window_background_blur = 20


config.window_background_opacity = 0.6
config.macos_window_background_blur = 70

-- tabs
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.window_frame = {
  active_titlebar_bg = "#282828",
  inactive_titlebar_bg = "#1d2021",
}

config.colors = {
  tab_bar = {
    background = "#1d2021",
    active_tab = {
      bg_color = "#d79921", -- gruvbox yellow
      fg_color = "#282828", -- dark fg for contrast
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#3c3836", -- dark gray
      fg_color = "#a89984", -- light gray fg
    },
    inactive_tab_hover = {
      bg_color = "#504945", -- lighter gray on hover
      fg_color = "#ebdbb2", -- light fg on hover
      italic = true,
    },
    new_tab = {
      bg_color = "#1d2021",
      fg_color = "#a89984",
    },
    new_tab_hover = {
      bg_color = "#458588", -- gruvbox blue
      fg_color = "#ebdbb2",
      italic = true,
    },
  },
}

return config
