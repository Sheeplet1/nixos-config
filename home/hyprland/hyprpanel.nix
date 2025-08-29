{ ... }:
{
  # Hyprpanel configuration
  enable = true;

  # Automatically restart hyprpanel with systemd for configuration changes.
  systemd.enable = true;

  settings = {
    theme = {
      name = "tokyo_night";
      font.name = "Iosevka Nerd Font Mono";
    };
    layout = {
      "bar.layouts" = {
        "*" = {
          left = [
            "dashboard"
            "workspaces"
            "windowtitle"
            "hyprsunset"
          ];
          middle = [ "media" ];
          right = [
            "volume"
            "network"
            "systray"
            "clock"
          ];
        };
      };
    };
  };
}
