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
      # "ctrl+h=goto_split:left"
      # "ctrl+l=goto_split:right"
      # "ctrl+j=goto_split:down"
      # "ctrl+k=goto_split:up"
    ];
  };
}
