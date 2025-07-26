{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../home/profiles/default.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    mkalias
    xcodes
  ];

  programs.aerospace = (import ./home/aerospace.nix { inherit pkgs; });
}
