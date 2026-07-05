{ pkgs, ... }:
{
  enable = true;
  settings = {
    general = {
      font-sans = "SF Pro Display Nerd Font";

    };
    styling = {
      theme-provider = "wayle";
      rounding = "sm";
    };

    bar = {
      location = "top";
      background-opacity = 100;
      rounding = "no";
      border-location = "none";
      padding = 0.35;
      padding-ends = 0.5;
      module-gap = 0.5;
      button-variant = "block-prefix";
      button-rounding = "sm";
      button-label-weight = "semibold";
      layout = [
        {
          monitor = "*";
          left = [
            "dashboard"
            "hyprland-workspaces"
            "window-title"
          ];
          center = [
            "cava"
            "media"
            "cava"
          ];
          right = [
            "network"
            "hyprsunset"
            # "systray"
            "idle-inhibit"
            "volume"
            "clock"
            "notifications"
          ];
        }
      ];
    };

    modules = {
      dashboard = {
        icon-override = "";
      };

      hyprland-workspaces = {
        min-workspace-count = 6;
        monitor-specific = false;
        show-special = false;
        display-mode = "label";
        label-use-name = false;
        numbering = "absolute";
        app-icons-show = true;
        workspace-ignore = [ "-99" ];
        active-indicator = "background";
      };

      cava = {
        bars = 20;
        framerate = 60;
        style = "bars";
        direction = "normal";
        left-click = "${pkgs.playerctl}/bin/playerctl play-pause";
      };

      window-title = {
        icon-show = true;
        label-show = true;
        label-max-length = 50;
      };

      volume = { };

      network = {
        label-show = false;
      };

      systray = { };

      idle-inhibit = {
        format = "{{ state }}";
        icon-active = "tb-coffee-symbolic";
        icon-inactive = "tb-coffee-off-symbolic";
        label-show = false;
        startup-duration = 60;
      };

      clock = {
        format = "%a %d %b %R";
        icon-show = true;
        label-show = true;
      };

      notifications = {
        popup-duration = 3500;
        popup-position = "top-right";
        popup-max-visible = 5;
      };

      media = {
        format = "{{ title }}";
        label-max-length = 25;
      };

      hyprsunset = {
        label-show = false;
      };
    };
  };
}
