local wezterm = require 'wezterm';

return {
  exit_behavior = "Close",
  color_scheme = "Cobalt2",
  initial_cols = 140,
  initial_rows = 40,
  -- fonts
  font = wezterm.font("JetBrains Mono", {weight="Light"}),
  font_size = 10.5,
  -- freetype_load_target = "HorizontalLcd",
  -- freetype_load_flags = "FORCE_AUTOHINT",

  -- keys = {
    -- search for things that look like git hashes
    -- {key="H", mods="SHIFT|CTRL", action=wezterm.action{Search={Regex="[a-f0-9]{6,}"}}},
  -- },

  selection_word_boundary = " \t\n{}[]()\"'`,;:",

  mouse_bindings = {
    -- Change the default click behavior to only selects text, not to open hyperlinks
    {
      event={Up={streak=1, button="Left"}},
      mods="NONE",
      action=wezterm.action{CompleteSelection="PrimarySelection"},
    },
    -- and make CTRL-Click open hyperlinks
    {event={Up={streak=1, button="Left"}}, mods="CTRL", action="OpenLinkAtMouseCursor"},
    {event={Down={streak=1, button="Left"}}, mods="CTRL", action="Nop"},
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
