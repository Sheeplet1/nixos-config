{ pkgs, ... }:
{
  enable = true;

  userSettings = {
    start-at-login = true;

    on-focus-changed = [ "move-mouse monitor-lazy-center" ];

    gaps = {
      outer.left = 8;
      outer.right = 8;
      outer.top = 8;
      outer.bottom = 8;
    };

    mode.main.binding = {
      alt-h = "focus left";
      alt-j = "focus down";
      alt-k = "focus up";
      alt-l = "focus right";

      alt-shift-h = "move left";
      alt-shift-j = "move down";
      alt-shift-k = "move up";
      alt-shift-l = "move right";

      alt-1 = "workspace 1";
      alt-2 = "workspace 2";
      alt-3 = "workspace 3";
      alt-4 = "workspace 4";
      alt-5 = "workspace 5";
      alt-6 = "workspace 6";
      alt-7 = "workspace 7";
      alt-8 = "workspace 8";
      alt-9 = "workspace 9";

      alt-shift-1 = "move-node-to-workspace 1";
      alt-shift-2 = "move-node-to-workspace 2";
      alt-shift-3 = "move-node-to-workspace 3";
      alt-shift-4 = "move-node-to-workspace 4";
      alt-shift-5 = "move-node-to-workspace 5";
      alt-shift-6 = "move-node-to-workspace 6";
      alt-shift-7 = "move-node-to-workspace 7";
      alt-shift-8 = "move-node-to-workspace 8";
      alt-shift-9 = "move-node-to-workspace 9";

      alt-tab = "workspace-back-and-forth";
      alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
    };

    workspace-to-monitor-force-assignment = {
      "1" = "secondary";
      "2" = "secondary";
      "3" = "main secondary";
      "4" = "main secondary";
      "5" = "main secondary";
      "6" = "main secondary";
      "7" = "main secondary";
    };

    on-window-detected = [
      # To get the bundle ID of an app, run: osascript -e 'id of app "SomeApp"'

      #  Workspace 1 - Terminals/Coding
      {
        "if".app-id = "com.mitchellh.ghostty";
        run = [
          "layout tiling"
          "move-node-to-workspace 1"
        ];
      }

      # Workspace 2 - Browsers
      {
        "if".app-id = "com.apple.Safari";
        run = [ "move-node-to-workspace 2" ];
      }
      {
        "if".app-id = "app.zen-browser.zen";
        run = [ "move-node-to-workspace 2" ];
      }

      # {
      #   "if".app-id = "com.todesktop.230313mzl4w4u92";
      #   run = [ "move-node-to-workspace 3" ];
      # }
      # {
      #   "if".app-id = "com.microsoft.VSCode";
      #   run = [ "move-node-to-workspace 3" ];
      # }

      # Workspace 3 - Messages
      {
        "if".app-id = "md.obsidian";
        run = [ "move-node-to-workspace 3" ];
      }

      # Messages
      {
        "if".app-id = "com.apple.MobileSMS";
        run = [ "move-node-to-workspace 4" ];
      }

      # Spotify
      {
        "if".app-id = "com.spotify.client";
        run = [ "move-node-to-workspace 5" ];
      }

      {
        "if".app-id = "com.hnc.Discord";
        run = [ "move-node-to-workspace 6" ];
      }
      {
        "if".app-id = "com.1password.1password";
        run = [ "move-node-to-workspace 7" ];
      }

      {
        "if".app-id = "com.TickTick.task.mac";
        run = [ "move-node-to-workspace 8" ];
      }
    ];
  };
}
