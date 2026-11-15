{
  lib,
  config,
  ...
}:
{
  options = {
    atHome.enable = lib.mkEnableOption "enables at home settings";
  };

  config = lib.mkIf config.atHome.enable {
    networking = {
      networkmanager.dns = "none";
      nameservers = [
        "192.168.50.50" # PiHole
        "192.168.50.1" # Gateway
      ];
      networkmanager.insertNameservers = [
        "192.168.50.50" # PiHole
        "192.168.50.1" # Gateway
      ];
    };
  };
}
