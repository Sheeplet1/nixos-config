{
  inputs,
  config,
  pkgs,
  ...
}:
let
  nvimConfigLocation = "${config.home.homeDirectory}/nix/home/nvim/nvim";
  scriptsLocation = "${config.home.homeDirectory}/nix/home/scripts";
in 
{
  # This configuration is for my Macbook VM which is basically a 
  # terminal replacement.

  programs.home-manager.enable = true;
  home.username = "anthonyd";
  home.homeDirectory = "/home/anthonyd";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
    EDITOR = "nvim";
  };

  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
  home.file.".scripts/".source = config.lib.file.mkOutOfStoreSymlink scriptsLocation;

  programs.alacritty = (import ./alacritty.nix { inherit pkgs; });
  programs.git = (import ./git.nix { inherit pkgs; });
  programs.fzf = (import ./fzf.nix { inherit pkgs; });
  programs.neovim = (import ./nvim/neovim.nix { inherit pkgs; });
  programs.tmux = (import ./tmux.nix { inherit inputs pkgs; });
  programs.zoxide = (import ./zoxide.nix { inherit pkgs; });
  programs.zsh = (import ./zsh.nix { inherit pkgs; });

  home.stateVersion = "24.05";
}
