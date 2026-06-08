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
  enablePackages.typescriptDevelopment.enable = true;

  home.packages = with pkgs; [
    mkalias
  ];

  programs.aerospace = (import ./home/aerospace.nix { inherit pkgs; });
}
