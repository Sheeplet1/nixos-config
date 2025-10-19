{ pkgs, ... }:
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
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.2)";
        font_color = "$foreground";
        fade_on_empty = false;
        rounding = -1;
        check_color = "rgb(204, 136, 34)";
        placeholder_text = "<i><span foreground=\"##cdd6f4\">Input Password...</span></i>";
        hide_input = false;
        position = "0, -50";
        halign = "center";
        valign = "center";
      }
    ];

    label = [
      {
        # Date
        monitor = "";
        text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
        color = "rgba(242, 243, 244, 0.75)";
        font_size = 22;
        font_family = "Iosevka Nerd Font";
        position = "0, 300";
        halign = "center";
        valign = "center";
      }
      {
        # Time
        monitor = "";
        text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
        color = "rgba(242, 243, 244, 0.75)";
        font_size = 95;
        font_family = "Iosevka";
        position = "0, 200";
        halign = "center";
        valign = "center";
      }
      {
        # "Hi there, {$USER}"
        monitor = "";
        text = "cmd[update:1000] echo Hi there, $USER";
        color = "rgba(242, 243, 244, 0.75)";
        font_size = 20;
        font_family = "Iosevka Nerd Font";
        position = "0, 0";
        halign = "center";
        valign = "center";
      }
    ];
  };
}
