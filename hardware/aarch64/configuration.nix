{
  inputs,
  config,
  pkgs,
  ...
}:
{
  import = [
    ../../modules/vm-aarch64.nix
  ];
}
