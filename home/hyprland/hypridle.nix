{ pkgs, ... }:
{
  enable = true;
  settings = {
    general = {
      # lock_cmd = notify-send "lock!";
      # unlock_cmd = notify-send "unlock!";
      before_sleep_cmd = "hyprlock";
      # whether to ignore dbus-sent idle-inhibit requests (used by e.g. firefox)
      ignore_dbus_inhibit = false; 
    };

    listener = [
      {
        timeout = 600; # 10 minutes
        on-timeout = "hyprlock";
      }
    ];
  };
}
