{
  inputs,
  config,
  pkgs,
  ...
}:
let
  nvimConfigLocation = "${config.home.homeDirectory}/nix/home/neovim/nvim";
  scriptsLocation = "${config.home.homeDirectory}/nix/home/scripts";
  wallpapersLocation = "${config.home.homeDirectory}/nix/home/hyprland/wallpapers";
in
{
  programs.home-manager.enable = true;
  home.username = "anthonyd";
  home.homeDirectory = "/home/anthonyd";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
    EDITOR = "nvim";
  };

  # Defining symlinks
  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
  home.file.".scripts/".source = config.lib.file.mkOutOfStoreSymlink scriptsLocation;
  home.file."Pictures/wallpapers/".source = config.lib.file.mkOutOfStoreSymlink wallpapersLocation;

  home.packages = with pkgs; [ ];

  # TODO: Modules
  programs.alacritty = (import ./alacritty.nix { inherit pkgs; });
  programs.git = (import ./git.nix { inherit pkgs; });
  programs.fzf = (import ./fzf.nix { inherit pkgs; });
  programs.hyprlock = (import ./hyprland/hyprlock.nix { inherit pkgs; });
  programs.neovim = (import ./neovim/neovim.nix { inherit pkgs; });
  programs.tmux = (import ./tmux.nix { inherit inputs pkgs; });
  # programs.waybar = (import ./waybar.nix { inherit pkgs; });
  programs.zoxide = (import ./zoxide.nix { inherit pkgs; });
  programs.zsh = (import ./zsh.nix { inherit pkgs; });
  programs.wofi = (import ./wofi/wofi.nix { inherit pkgs; });

  services.hypridle = (import ./hyprland/hypridle.nix { inherit pkgs; });

  wayland.windowManager.hyprland = (import ./hyprland/hyprland.nix { inherit pkgs; });

  home.stateVersion = "24.05";
}
