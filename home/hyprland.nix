{ pkgs, ... }:
{
  enable = true;
  settings = {
    "$mod" = "SUPER";

    general = {
      gaps_in = 12;
      gaps_out = 28;
      border_size = 2;
      resize_on_border = true;
      layout = "master";
    };

    decoration = {
      rounding = 10;

      active_opacity = 0.95;
      inactive_opacity = 0.8;
      fullscreen_opacity = 1;

      dim_inactive = true;
      dim_strength = 0.1;
      dim_special = 0.8;

      drop_shadow = true;
      shadow_range = 6;
      shadow_render_power = 1;

      blur = {
        enabled = true;
        size = 6;
        passes = 2;
        ignore_opacity = true;
        new_optimizations = true;
        special = true;
      };
    };

    # animations = {
    #     enabled = "yes";
    #
    #     animation = "windows, 1, 6, wind, slide";
    # };

    # TODO: Add in zen-browser or firefox depending on machine
    bind =
      [
        "$mod, RETURN, exec, alacritty"
        "$mod, Q, killactive"
        "$mod, D, exec, pkill wofi || wofi --show drun"
        # "$mod, D, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window"
        "$mod, T, exec, thunar"
        "$mod, M, exit"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 10
      ));
  };
  extraConfig = ''
    windowrulev2 = workspace 2, class:^([Ff]irefox)$;
  '';
}
