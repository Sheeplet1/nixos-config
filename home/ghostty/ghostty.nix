{
  config,
  lib,
  pkgs,
  ...
}:
let
  ghosttyConfigLocation = "${config.home.homeDirectory}/nix/home/ghostty/themes";
in
{
  home.file.".config/ghostty/themes".source =
    config.lib.file.mkOutOfStoreSymlink ghosttyConfigLocation;

  xdg.configFile."ghostty/config".text = ''
    font-family = "Iosevka Nerd Font Mono"
    font-size = 18

    theme = tokyonight 
    window-theme = ghostty
  '';
}
