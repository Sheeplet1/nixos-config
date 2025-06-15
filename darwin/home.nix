{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../home/profiles/default.nix
  ];

  xdg.enable = true;

  programs.aerospace = (import ./home/aerospace.nix { inherit pkgs; });
}
