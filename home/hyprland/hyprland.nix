{ pkgs, ... }:
{
  enable = true;
  settings = {
    "$mod" = "SUPER";

    exec-once = [
      "hyprpanel &"
      "obsidian --ozone-platform-hint=auto &"
      "todoist --ozone-platform-hint=auto &"
      "spotify"
      "zen &"
      "alacritty &"
    ];

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

    cursor = {
      no_hardware_cursors = true;
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
        "fade, 1, 10, default"
        "workspaces, 1, 10, wind"
      ];
    };

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

        # hyprshot
        "$mod, PRINT, exec, hyprshot -m window" # window
        ", PRINT, exec, hyprshot -m output" # monitor
        "mod SHIFT, PRINT, exec, hyprshot -m region" # region

        # Controlling media via keyboard
        ", xf86AudioPlayPause, exec, bash $HOME/.scripts/media_controls.sh --pause"
        ", xf86AudioPause, exec, bash $HOME/.scripts/media_controls.sh --pause"
        ", xf86AudioPlay, exec, bash $HOME/.scripts/media_controls.sh --pause"
        ", xf86AudioNext, exec, bash $HOME/.scripts/media_controls.sh --nxt"
        ", xf86AudioPrev, exec, bash $HOME/.scripts/media_controls.sh --prv"
        ", xf86Audiostop, exec, bash $HOME/.scripts/media_controls.sh --stop"

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
      ++ (if pkgs.system == "x86_64-linux" then ["$mod, b, exec, zen"] else ["$mod, b, exec, firefox"]);
  };
  extraConfig = ''
    # Monitors
    monitor=DP-1, 3440x1440@175, 0x0, 1
    monitor=DP-2, disable
    monitor=DP-3, disable
    # Uncomment the below and comment out the above to re-enable other monitors
    # monitor=DP-2, 1920x1080@60, 3440x0, 1
    # monitor=DP-3, 1920x1080@60, -1920x0, 1

    # Defining workspaces
    workspace = 1, monitor:DP-1
    workspace = 2, monitor:DP-1

    workspace = 3, monitor:DP-2
    workspace = 4, monitor:DP-2

    workspace = 5, monitor:DP-3
    workspace = 6, monitor:DP-3

    # Workspace Rules
    windowrulev2 = workspace 2, class:^([Vv]ivaldi-stable)$
    windowrulev2 = workspace 2, class:^([Ff]irefox)$
    windowrulev2 = workspace 2, initialTitle:^([Zz]en Browser)$

    windowrulev2 = workspace 1, class:^([Aa]lacritty)$

    windowrulev2 = workspace 4, class:^([Oo]bsidian)$

    windowrulev2 = workspace 3, initialTitle:^([Ss]potify)$

    windowrulev2 = workspace 5, class:^([Tt]odoist)$

    windowrulev2 = workspace 6, class:^([Dd]iscord)$
    windowrulev2 = workspace 6, class:^([Ww]ebCord)$
    windowrulev2 = workspace 6, class:^([Vv]esktop)$

    # Defining floats 
    windowrulev2 = float, class:^(org.kde.polkit-kde-authentication-agent-1)$ 
    windowrulev2 = float, class:([Zz]oom|onedriver|onedriver-launcher)$
    windowrulev2 = float, class:([Tt]hunar), title:(File Operation Progress)
    windowrulev2 = float, class:([Tt]hunar), title:(Confirm to replace files)
    windowrulev2 = float, class:(xdg-desktop-portal-gtk)
    windowrulev2 = float, class:(org.gnome.Calculator), title:(Calculator)

    # Defining positions
    windowrulev2 = center, class:([Tt]hunar), title:(File Operation Progress)
    windowrulev2 = center, class:([Tt]hunar), title:(Confirm to replace files)
  '';
}
