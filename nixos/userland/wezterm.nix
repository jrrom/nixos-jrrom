{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}
      
      config.front_end = "WebGpu"
      config.enable_wayland = true

      config.window_close_confirmation = 'NeverPrompt'

      -- scrollbar
      config.enable_scroll_bar = true

      -- padding
      config.window_padding = {
        left = 2,
        right = 0,
        top = 2,
        bottom = 0.
      };
      
      -- fancypants
      config.window_background_opacity = 0.9;
      

      -- tab bar
      config.enable_tab_bar = true
      config.hide_tab_bar_if_only_one_tab = false
      config.use_fancy_tab_bar = false
      config.tab_max_width = 25
      config.show_tab_index_in_tab_bar = false
      config.switch_to_last_active_tab_when_closing_tab = true
      
      config.keys = {
        { key = "t", mods="SHIFT|CMD", action=wezterm.action.SpawnTab 'DefaultDomain' },
        { key = "d", mods="SHIFT|CMD", action=wezterm.action.CloseCurrentTab { confirm = true } }
      }
      
      return config
    '';
  };
}
