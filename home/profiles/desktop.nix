# Desktop environment home-manager profile.
{
  inputs,
  config,
  pkgs,
  ...
}:
let
  atkinsonHyperlegible = {
    package = pkgs.atkinson-hyperlegible;
    name = "Atkinson Hyperlegible";
  };
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

  stylix.targets = {
    firefox = {
      profileNames = [ "default" ];
      fonts.override = {
        sansSerif = atkinsonHyperlegible;
        serif = atkinsonHyperlegible;
      };
    };

    # The native target cannot merge its singleton attributes with this layout's lists.
    hyprlock.enable = false;
  };

  programs = {
    firefox = {
      enable = true;

      # Firefox is installed system-wide, so Home Manager only manages its profile.
      package = null;

      # Firefox already follows XDG_CONFIG_HOME, while Home Manager 24.11 defaults to ~/.mozilla.
      configPath = ".config/mozilla/firefox";

      # Target the existing profile instead of creating a blank one.
      profiles.default.path = "hwdpg3rl.default";
    };
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
