# Desktop environment home-manager profile.
{
  inputs,
  config,
  pkgs,
  ...
}:
let
  wallpapersLocation = "${config.home.homeDirectory}/nix/home/hyprland/wallpapers";
in
{
  imports = [
    ./default.nix
    inputs.hyprpanel.homeManagerModules.hyprpanel
  ];

  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_PICTURES_DIR = "$HOME/Pictures";
    HYPRSHOT_DIR = "$HOME/Pictures/screenshots";

    # Firefox
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.packages = with pkgs; [
    dconf # required for gtk.enable
    prusa-slicer
  ];

  # Defining symlinks
  home.file."Pictures/wallpapers/".source = config.lib.file.mkOutOfStoreSymlink wallpapersLocation;

  # GTK Theming
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
  };

  programs = {
    ghostty = (import ../ghostty.nix { inherit pkgs; });
    hyprpanel = (import ../hyprland/hyprpanel.nix { inherit pkgs; });
    hyprlock = (import ../hyprland/hyprlock.nix { inherit pkgs; });
    wofi = (import ../wofi/wofi.nix { inherit pkgs; });
  };

  # Services
  services.hypridle = (import ../hyprland/hypridle.nix { inherit pkgs; });

  wayland.windowManager.hyprland = (import ../hyprland/hyprland.nix { inherit pkgs; });

  home.stateVersion = "24.11";
}
