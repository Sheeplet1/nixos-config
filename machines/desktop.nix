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
  ];

  desktop.enable = true;
  nvidia.enable = true;
  atHome.enable = true;
}
