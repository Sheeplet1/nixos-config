{
  inputs,
  config,
  configs,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/default.nix
    ../../modules/desktop.nix
    ../../modules/nvidia.nix
  ];

  desktop.enable = true;
  nvidia.enable = true;
}
