{ pkgs, ... }:
{
  enable = true;

  style = ''
    * {
      font-family: "Iosevka Nerd Font", "JetBrains Mono Nerd Font";
      font-weight: 600;
      font-size: 16px;
    }

    window#waybar {
      background-color: rgba(48, 45, 65, 1);
      border-bottom: 3px solid rgba(110, 108, 126, 1);
      color: #d9e0ee;
      transition-property: background-color;
      transition-duration: .5s;
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #disk,
    #temperature,
    #network,
    #pulseaudio,
    #hyprland-workspaces,
    #custom-media,
    #custom-power,
    #tray,
    #mpd {
      padding: 0 10px;
      background-color: rgba(48, 45, 65, 1);
      border-bottom: 3px solid rgba(110, 108, 126, 1);
      /* color: #d9e0ee; */
    }
  '';

  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [
        "network"
        "pulseaudio"
        "battery"
        "custom/power"
      ];

      clock = {
        format = "{:%H:%M - %A %d.}";
      };

      battery = {
        states = {
          # good: 95;
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        # "format-good" = "", // An empty format will hide the module
        # "format-full" = "",
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };

      "hyprland/window" = {
        max-length = 30;
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
          default = [
            ""
            ""
            ""
          ];
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

      network = {
        format-wifi = "{essid} {{signalStrength}% }";
        format-ethernet = "󰈀";
        tooltip-format = "{ifname} via {gwaddr} ";
        format-linked = "{ifname} (No IP) ";
        format-disconnected = "Disconnected ⚠";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
      };
    };
  };
}
