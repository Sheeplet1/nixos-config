{
  ...
}:
{
  imports = [
    ./hardware/desktop.nix

    ../modules/default.nix
    ../modules/desktop.nix
    ../modules/nvidia.nix
    ../modules/home.nix
    ../modules/homelab.nix
  ];

  desktop.enable = true;
  nvidia.enable = true;
  atHome.enable = true;
  homelab.enable = true;
}
