# Desktop environment home-manager profile.
{
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
  ];

  home.packages = with pkgs; [
    prusa-slicer
  ];

  # Defining symlinks
  home.file."Pictures/wallpapers/".source = config.lib.file.mkOutOfStoreSymlink wallpapersLocation;

  programs.hyprlock = (import ../hyprland/hyprlock.nix { inherit pkgs; });
  programs.wofi = (import ../wofi/wofi.nix { inherit pkgs; });

  services.hypridle = (import ../hyprland/hypridle.nix { inherit pkgs; });

  wayland.windowManager.hyprland = (import ../hyprland/hyprland.nix { inherit pkgs; });

  home.stateVersion = "24.05";
}