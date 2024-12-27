{
  config,
  lib,
  pkgs,
  ...
}:
{
  xdg.configFile."ghostty/config".text = ''
    font-family = "Iosevka Nerd Font Mono"
    font-size = 18

    theme = tokyonight
  '';
}
