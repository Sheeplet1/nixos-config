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
      # Point DNS to Pihole
      nameservers = [
        "192.168.50.50"
        "192.168.50.1"
      ];
      networkmanager.insertNameservers = [
        "192.168.50.50"
        "192.168.50.1"
      ];
    };
  };
}
