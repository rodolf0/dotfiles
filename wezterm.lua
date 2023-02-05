local wezterm = require 'wezterm';

return {
  -- enable_wayland = false,
  window_frame = {
    border_left_width = '0.2cell', border_left_color = '#4267b2',
    border_right_width = '0.2cell', border_right_color = '#4267b2',
    border_top_height = '0.1cell', border_top_color = '#4267b2',
    border_bottom_height = '0.1cell', border_bottom_color = '#4267b2',
  },
  window_padding = { left = 0, right = 0, top = 0, bottom = 0, },

  exit_behavior = "Close",
  color_scheme = "Elio (Gogh)",
  initial_cols = 140,
  initial_rows = 40,
  hide_tab_bar_if_only_one_tab = true,

  -- fonts
  font = wezterm.font("JetBrains Mono NL", {weight="Medium"}),
  font_size = 10.5,
  warn_about_missing_glyphs = false,
  -- freetype_load_target = "HorizontalLcd",
  -- freetype_load_flags = "FORCE_AUTOHINT",

  -- keys = {
    -- search for things that look like git hashes
    -- {key="H", mods="SHIFT|CTRL", action=wezterm.action{Search={Regex="[a-f0-9]{6,}"}}},
  -- },

  selection_word_boundary = " \t\n{}[]()<>\"'`,;:=",

  mouse_bindings = {
    -- Default behavior is to follow open links. Disable, just select text.
    {event={Up={streak=1, button="Left"}}, mods="NONE", action=wezterm.action.CompleteSelection("PrimarySelection")},
    -- and make CTRL-Click open hyperlinks (even when mouse reporting)
    {event={Up={streak=1, button="Left"}}, mods="CTRL", action="OpenLinkAtMouseCursor", mouse_reporting=true},
    {event={Up={streak=1, button="Left"}}, mods="CTRL", action="OpenLinkAtMouseCursor"},
    -- Since we capture the 'Up' event, Disable 'Down' of ctrl-click to avoid programs from receiving it
    {event={Down={streak=1, button="Left"}}, mods="CTRL", action="Nop", mouse_reporting=true},
  },

  hyperlink_rules = {
    -- configerator files 
    {
      regex = "\\bconfigerator/source/([^[:space:]:$'\"]+)",
      format = "https://www.internalfb.com/intern/diffusion/CF/browse/master/source/$1",
    },
    -- fbcode files
    {
      regex = "\\bfbcode/([^[:space:]:$'\"]+)",
      format = "https://www.internalfb.com/intern/diffusion/FBS/browse/master/fbcode/$1",
    },
    -- fbcode stack-traces
    {
      regex = "\\./((?:zookeeper|delos|delos_core|thrift|zeus|folly)/[^:]+\\.(?:cpp|h|py|cc|hpp)):?([0-9]+|)\\b",
      format = "https://www.internalfb.com/intern/diffusion/FBS/browse/master/fbcode/$1?lines=$2",
    },
    -- Pastes
    {
      regex = "\\bP[0-9]{5,10}\\b",
      format = "https://www.internalfb.com/intern/paste/$0",
    },
    -- Diffs
    {
      regex = "\\bD[0-9]{5,10}\\b",
      format = "https://www.internalfb.com/intern/diff/$0",
    },
    -- Tasks
    {
      regex = "\\b[tT]([0-9]{5,10})\\b",
      format = "https://www.internalfb.com/intern/tasks/?t=$1",
    },
    -- SEVs
    {
      regex = "\\b[sS][0-9]{5,7}\\b",
      format = "https://www.internalfb.com/intern/sevmanager/view/s/$0/",
    },
    -- TW jobs
    {
      regex = "(?:priv|tsp)_(?:[a-z]{3,6})/[-_.[:alnum:]]+/[-_.[:alnum:]]+",
      format = "https://www.internalfb.com/intern/tupperware/details/job/?handle=$0",
    },
    -- SMC tiers
    {
      regex = "\\b(?:zelos|zeus|delos|delos_table)\\.[a-zA-Z0-9_.-]+\\b",
      format = "https://www.internalfb.com/intern/smc/properties/?tier_name=$0",
    },
    -- TW tasks
    {
      regex = "(?:priv|tsp)_(?:[a-z]{3,6})/[-_.[:alnum:]]+/[-_.[:alnum:]]+/[0-9]+",
      format = "https://www.internalfb.com/intern/tupperware/details/task/?handle=$0",
    },

    -- Linkify things that look like URLs
    -- This is actually the default if you don't specify any hyperlink_rules
    {
      regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },
    -- file:// URI
    {
      regex = "\\bfile://\\S*\\b",
      format = "$0",
    },
  },
}
