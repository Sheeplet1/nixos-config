{ config, ... }:
let
  colors = config.lib.stylix.colors;
  font = config.stylix.fonts.monospace.name;
in
{
  enable = true;
  settings = {
    general = {
      grace = 1;
      no_fade_in = true;
      no_fade_out = true;
      hide_cursor = false;
      disable_loading_bar = true;
    };

    background = [
      {
        path = "/home/anthonyd/nix/home/hyprland/wallpapers/mist_forest_1.png";
        blur_size = 8;
        blur_passes = 3;
      }
    ];

    input-field = [
      {
        monitor = "";
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgba(${colors.base03}00)";
        inner_color = "rgba(${colors.base00}33)";
        font_color = "rgb(${colors.base05})";
        fail_color = "rgb(${colors.base08})";
        fade_on_empty = false;
        rounding = -1;
        check_color = "rgb(${colors.base0A})";
        placeholder_text = "<i><span foreground=\"##${colors.base05}\">Input Password...</span></i>";
        hide_input = false;
        position = "0, -60";
        halign = "center";
        valign = "center";
      }
    ];

    label = [
      {
        # Date
        monitor = "";
        text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
        color = "rgba(${colors.base05}bf)";
        font_size = 22;
        font_family = font;
        position = "0, 300";
        halign = "center";
        valign = "center";
      }
      {
        # Time
        monitor = "";
        text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
        color = "rgba(${colors.base05}bf)";
        font_size = 95;
        font_family = font;
        position = "0, 200";
        halign = "center";
        valign = "center";
      }
      {
        # "Hi there, {$USER}"
        monitor = "";
        text = "cmd[update:1000] echo Hi there, $USER";
        color = "rgba(${colors.base05}bf)";
        font_size = 20;
        font_family = font;
        position = "0, 0";
        halign = "center";
        valign = "center";
      }
    ];
  };
}
