{ pkgs, ... }:
{
  enable = true;
  package = if pkgs.stdenv.isDarwin then null else pkgs.ghostty;
  enableFishIntegration = true;
  settings = {
    command = "${pkgs.fish}/bin/fish --login --interactive";
    font-size = 12;
    font-family = "JetBrains Mono";
    window-theme = "ghostty";
    macos-option-as-alt = true;
    macos-non-native-fullscreen = "visible-menu";
    macos-titlebar-style = "transparent";
    window-decoration = "auto";
    background-opacity = 0.95;
    background-blur-radius = 20;
    keybind = [
      "cmd+h=goto_split:left"
      "cmd+l=goto_split:right"
      "cmd+j=goto_split:down"
      "cmd+k=goto_split:up"
    ];
  };
}
