{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = {
      mainBar = {
        "layer" = "top";
	"position" = "top";
	"height" = 18;
	
        "modules-left" = [
          "sway/workspaces"
        ];

        "modules-center" = [
          "clock"
        ];

        "modules-right" = [
          "custom/screenshot"
          "custom/separator"
          "battery"
	  "backlight/slider"
	  "custom/separator"
	  "pulseaudio"
	  "pulseaudio/slider"
	  "custom/separator"
	  "custom/space"
	  "tray"
	  "custom/space"
	  "custom/space"
        ]; 

        "custom/screenshot" = {
          "format" = "     ";
          "on-click" = ''grim -g "$(slurp)" - | swappy -f -'';
        };

        "clock" = {
          "interval" = 1;
          "format" = "󰅐   {:%H:%M:%S  |  %A - %B %d, %Y}";
          "tooltip-format" = "{:%Y-%m-%d | %H:%M:%S}";
        };
        
        "pulseaudio" = {
          "format" = "{icon}  {volume}%   {format_source}";
          "format-muted" = "󰖁  {format_source}";
          "format-bluetooth" = "{icon}󰂯 {volume}% {format_source}";
          "format-bluetooth-muted" = "󰖁󰂯 {format_source}";
        	 
          "format-source" = "󰍬  {volume}%";
          "format-source-muted" = "󰍭";
        
          "format-icons" = {
            "headphones" = "󰋋";
            "handsfree" = "󱡏";
            "headset" = "󰋋";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
        };
        
        "custom/separator" = {
          format = " | ";
          tooltip = false;
        };

        "custom/space" = {
          format = "   ";
          tooltip = false;
        };
        
        "tray" = {
          spacing = 10;
        };
        
        "battery" = {
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon} {capacity}%";
          "format-charging" = "{icon}  {power} W";
          "tooltip-format" = "{timeTo}, {capacity}%\n {power} W";
          "format-icons" = [
             "󰁺"
             "󰁻"
             "󰁼"
             "󰁽"
             "󰁾"
             "󰁿"
             "󰂀"
             "󰂁"
             "󰂂"
             "󰁹"
          ];
        };
      };
    };
    style = ''
      * { font-size: 16px; }

      #backlight-slider slider, #pulseaudio-slider slider  { min-height: 4px; min-width: 4px; }
      #backlight-slider trough, #pulseaudio-slider trough  { min-width: 60px; min-height: 2px; }

    '';
  };
}
