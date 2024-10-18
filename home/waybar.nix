{ pkgs, ... }:
{
  enable = true;
  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;

      modules-left = [ "hyprland/workspaces" "sway/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "battery" "pulseaudio" "custom/power" ];

      clock = {
        format = "{:%H:%M}";
      };

      battery = {
        format = "{capacity} {icon}";
      };

      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
        };
        on-click = "pavucontrol";
      };

      "custom/power" = {
          format = "⏻ ";
          tooltip = false;
          menu = "on-click";
          menu-file = "$HOME/.config/waybar/power_menu.xml";
          menu-actions = {
            shutdown = "shutdown";
            reboot = "reboot";
            suspend = "systemctl suspend";
            hibernate = "systemctl hibernate";
          };
      };
    };
  };
}
