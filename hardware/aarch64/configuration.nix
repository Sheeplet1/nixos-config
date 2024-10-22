{
  inputs,
  config,
  pkgs,
  ...
}:
{
  import = [
    ../../modules/default.nix
    ../../modules/vm-aarch64.nix
  ];
}
