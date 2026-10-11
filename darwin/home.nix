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

  enablePackages.shellDevelopment.enable = true;
  enablePackages.rustDevelopment.enable = true;
  # enablePackages.javaDevelopment.enable = true;
  enablePackages.zigDevelopment.enable = true;

  home.packages = with pkgs; [
    mkalias
  ];

  stylix.overlays.enable = false;

  programs.aerospace = (import ./home/aerospace.nix { inherit pkgs; });
}
