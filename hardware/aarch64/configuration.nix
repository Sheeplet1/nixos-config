{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/default.nix
    ../../modules/vm-aarch64.nix
  ];
}
