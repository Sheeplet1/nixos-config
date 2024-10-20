{
  inputs,
  config,
  pkgs,
  ...
}:
let
  nvimConfigLocation = "${config.home.homeDirectory}/nix/home/nvim/nvim";
in 
{
  imports = [
    ./ags/ags.nix
  ];

  programs.home-manager.enable = true;
  home.username = "anthonyd";
  home.homeDirectory = "/home/anthonyd";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
    EDITOR = "nvim";
  };

  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;

  home.packages = with pkgs; [ ];

  programs.alacritty = (import ./alacritty.nix { inherit pkgs; });
  programs.git = (import ./git.nix { inherit pkgs; });
  programs.hyprlock = (import ./hyprland/hyprlock.nix { inherit pkgs; });
  programs.tmux = (import ./tmux.nix { inherit inputs pkgs; });
  programs.waybar = (import ./waybar.nix { inherit pkgs; });
  programs.zoxide = (import ./zoxide.nix { inherit pkgs; });
  programs.zsh = (import ./zsh.nix { inherit pkgs; });

  services.hypridle = (import ./hyprland/hypridle.nix { inherit pkgs; });

  wayland.windowManager.hyprland = (import ./hyprland/hyprland.nix { inherit pkgs; });

  home.stateVersion = "24.05";
}
