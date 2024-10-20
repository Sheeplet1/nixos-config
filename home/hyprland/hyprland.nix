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

    cursor = {
      no_hardware_cursors = true;
    };

    animations = {
      enabled = "yes";
      bezier = [
        # "overshot, 0.05, 0.9, 0.1, 1.05"
        # "smoothOut, 0.36, 0, 0.66, -0.56"
        # "smoothIn, 0.25, 1, 0.5, 1"
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.1, 1.1, 0.1, 1.1"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
      ];
      animation = [
        # https://github.com/hyper-dot/Arch-Hyprland/blob/main/.config/hypr/decoration.conf
        # "windows, 1, 3, overshot, slide"
        # "windowsOut, 1, 3, smoothOut, slide"
        # "windowsMove, 1, 3, default"
        # "border, 1, 3, default"
        # "fade, 1, 3, smoothIn"
        # "fadeDim, 1, 3, smoothIn"
        # "workspaces, 1, 3, default"
        "windows, 1, 6, wind, slide"
        "windowsIn, 1, 6, winIn, slide"
        "windowsOut, 1, 5, winOut, slide"
        "windowsMove, 1, 5, wind, slide"
        "border, 1, 1, liner"
        # borderangle, 1, 180, liner, loop #used by rainbow borders and rotating colors
        "fade, 1, 10, default"
        "workspaces, 1, 10, wind"
      ];
    };

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

        # TODO: Need to make scripts the NixOS way 
        # https://www.youtube.com/watch?v=diIh0P12arA
        # "CTRL ALT, P, exec, ./scripts/wlogout.sh"
        # "CTRL ALT, L, exec, ./scripts/lock_screen.sh"
        # "$mod, C, exec, ./scripts/change_audio_device.sh"
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
      ++ (if pkgs.system == "x86_64-linux" then ["$mod, c, exec, zen"] else ["$mod, c, exec, firefox"]);
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

    windowrulev2 = workspace 3, class:^([Ss]potify)$

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
