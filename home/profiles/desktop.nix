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
    ../stylix.nix
    ./default.nix
  ];

  enablePackages.shellDevelopment.enable = true;
  enablePackages.rustDevelopment.enable = true;

  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_PICTURES_DIR = "$HOME/Pictures";
    HYPRSHOT_DIR = "$HOME/Pictures/screenshots";

    # Firefox
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.packages = with pkgs; [
    opencode
    dconf # required for gtk.enable
  ];

  # Defining symlinks
  home.file."Pictures/wallpapers/".source = config.lib.file.mkOutOfStoreSymlink wallpapersLocation;

  # The native target cannot merge its singleton attributes with this layout's lists.
  stylix.targets.hyprlock.enable = false;

  programs = {
    hyprlock = (import ../hyprland/hyprlock.nix { inherit config; });
    java = {
      enable = true;
      package = pkgs.jdk25;
    };
    wofi = (import ../wofi/wofi.nix { inherit pkgs; });
  };

  # Services
  services.hypridle = (import ../hyprland/hypridle.nix { inherit pkgs; });
  services.hyprsunset = (import ../hyprland/hyprsunset.nix { inherit pkgs; });
  services.wayle = (import ../wayle.nix { inherit pkgs; });

  wayland.windowManager.hyprland = (import ../hyprland/hyprland.nix { inherit pkgs; });

  home.stateVersion = "24.11";
}
