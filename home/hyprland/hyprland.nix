{ pkgs, ... }:
{
  enable = true;
  settings = {
    "$mod" = "SUPER";

    exec-once = [
      # "hyprlock"
      "swww-daemon --format xrgb"
      # "~/.scripts/wallpaper_auto_change.sh ~/Pictures/wallpapers"
      "hyprpanel"
      "obsidian --ozone-platform-hint=auto"
      "todoist-electron --ozone-platform-hint=auto"
      "zen"
      "ghostty"
    ] ++ (if pkgs.system == "x86_64-linux" then [ "hyprlock" ] else [ ]);

    general = {
      gaps_in = 12;
      gaps_out = 28;
      border_size = 2;
      resize_on_border = true;
      layout = "master";
      "col.active_border" = "rgb(d3869b) rgb(d3869b)";
    };

    decoration = {
      rounding = 10;

      active_opacity = 1;
      inactive_opacity = 0.9;
      fullscreen_opacity = 1;

      dim_inactive = true;
      dim_strength = 0.1;
      dim_special = 0.8;

      shadow = {
        enabled = true;
        color = "rgb(211, 134, 155)";
        range = 6;
        render_power = 1;
      };

      blur = {
        enabled = true;
        size = 6;
        passes = 2;
        ignore_opacity = true;
        new_optimizations = true;
        special = true;
      };
    };

    cursor = {
      no_hardware_cursors = true;
    };

    input = {
      repeat_rate = 33;
      repeat_delay = 225;
    };

    animations = {
      enabled = "yes";
      bezier = [
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.1, 1.1, 0.1, 1.1"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
      ];
      animation = [
        "windows, 1, 6, wind, slide"
        "windowsIn, 1, 6, winIn, slide"
        "windowsOut, 1, 5, winOut, slide"
        "windowsMove, 1, 5, wind, slide"
        "border, 1, 1, liner"
        "fade, 1, 8, default"
        "workspaces, 1, 10, wind"
      ];
    };

    monitor = [
      "DP-1, 3440x1440@175, 0x0, 1"
      # "DP-2, disable"
      "DP-3, disable"
      # Uncomment to re-enable monitors and comment out the above
      "DP-2, 1920x1080@60, 3440x0, 1"
      # "DP-3, 1920x1080@60, -1920x0, 1"
    ];

    workspace = [
      "1, monitor:DP-1"
      "2, monitor:DP-1"
      "3, monitor:DP-1"

      "4, monitor:DP-2"
      # "5, monitor:DP-3"
      # "6, monitor:DP-3"
      "5, monitor:DP-2"
      "6, monitor:DP-2"
    ];

    windowrulev2 = [
      # Workspaces
      "workspace 1, class:^([Aa]lacritty)$"
      "workspace 1, class:^(com.mitchellh.ghostty)$"

      "workspace 2, class:^([Vv]ivaldi-stable)$"
      "workspace 2, class:^([Ff]irefox)$"
      "workspace 2, initialTitle:^([Zz]en Browser)$"

      "workspace 3, class:^([Oo]bsidian)$"

      "workspace 4, initialTitle:^([Ss]potify)$"
      "workspace 4, initialTitle:^([Ss]potify Premium)$"

      "workspace 5, class:^([Dd]iscord)$"
      "workspace 5, class:^([Ww]ebCord)$"
      "workspace 5, class:^([Vv]esktop)$"

      "workspace 6, class:^([Tt]odoist)$"

      # Floats
      "float, class:^(org.kde.polkit-kde-authentication-agent-1)$"
      "float, class:([Zz]oom|onedriver|onedriver-launcher)$"
      "float, class:([Tt]hunar), title:(File Operation Progress)"
      "float, class:([Tt]hunar), title:(Confirm to replace files)"
      "float, class:(xdg-desktop-portal-gtk)"
      "float, class:(org.gnome.Calculator), title:(Calculator)"

      # Positions
      "center, class:([Tt]hunar), title:(File Operation Progress)"
      "center, class:([Tt]hunar), title:(Confirm to replace files)"
    ];

    # Move/resize windows with $mod + LMB/RMB
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bind =
      [
        "$mod, RETURN, exec, alacritty"
        "$mod, Q, killactive"
        "$mod, D, exec, pkill wofi || wofi --show drun"
        # "$mod, D, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window"
        "$mod, T, exec, thunar"
        "$mod, M, exit"
        "$mod, F, fullscreen"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod SHIFT, left, resizeactive, -10 0"
        "$mod SHIFT, right, resizeactive, 10 0"
        "$mod SHIFT, up, resizeactive, 0 -10"
        "$mod SHIFT, down, resizeactive, 0 10"

        "$mod CTRL, left, movewindow, l"
        "$mod CTRL, right, movewindow, r"
        "$mod CTRL, up, movewindow, u"
        "$mod CTRL, down, movewindow, d"

        "$mod SHIFT, f, togglefloating"
        "$mod SHIFT, Tab, workspace, m-1"
        "$mod, Tab, workspace, m+1"

        # wallpapers
        "$mod, W, exec, bash $HOME/.scripts/wallpaper_select.sh"
        "CTRL ALT, W, exec, bash $HOME/.scripts/wallpaper_random.sh"

        # hyprshot
        ", PRINT, exec, hyprshot -m output" # whole monitor
        "$mod, PRINT, exec, hyprshot -m window" # window
        "$mod, S, exec, hyprshot -m region" # like Windows snipping tool

        # hyprpicker
        "$mod, p, exec, hyprpicker -a -f hex"

        # Controlling media via keyboard
        # ", xf86AudioPlayPause, exec, bash $HOME/.scripts/media_controls.sh --pause"
        # ", xf86AudioPause, exec, bash $HOME/.scripts/media_controls.sh --pause"
        # ", xf86AudioPlay, exec, bash $HOME/.scripts/media_controls.sh --pause"
        # ", xf86AudioNext, exec, bash $HOME/.scripts/media_controls.sh --nxt"
        # ", xf86AudioPrev, exec, bash $HOME/.scripts/media_controls.sh --prv"
        # ", xf86Audiostop, exec, bash $HOME/.scripts/media_controls.sh --stop"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"

        "$mod, L, exec, bash $HOME/.scripts/lock_screen.sh"
        "CTRL ALT, P, exec, bash $HOME/.scripts/wlogout.sh"
        "$mod, C, exec, bash $HOME/.scripts/change_audio_device.sh"
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
            "$mod CTRL, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
          ]
        ) 10
      ))
      ++ (
        if pkgs.system == "x86_64-linux" then [ "$mod, b, exec, zen" ] else [ "$mod, b, exec, firefox" ]
      );
  };
  extraConfig = '''';
}
