{
  inputs,
  config,
  pkgs,
  ...
}:
let
  nvimConfigLocation = "${config.home.homeDirectory}/nix/home/neovim/nvim";
  scriptsLocation = "${config.home.homeDirectory}/nix/home/scripts";
in
{
  programs.home-manager.enable = true;
  home.username = "anthonyd";
  home.homeDirectory = "/home/anthonyd";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
    EDITOR = "nvim";
  };

  nix.nixPath = [
    "nixos-config=/home/anthonyd/nix/configuration.nix"
    "nixpkgs=${inputs.nixpkgs}"
  ];

  home.packages = with pkgs; [
    zsh-powerlevel10k
    meslo-lgs-nf
  ];

  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
  home.file.".scripts/".source = config.lib.file.mkOutOfStoreSymlink scriptsLocation;

  programs.alacritty = (import ./alacritty.nix { inherit pkgs; });
  programs.git = (import ./git.nix { inherit pkgs; });
  programs.fzf = (import ./fzf.nix { inherit pkgs; });
  programs.neovim = (import ./neovim/neovim.nix { inherit pkgs; });
  programs.tmux = (import ./tmux.nix { inherit inputs pkgs; });
  programs.zoxide = (import ./zoxide.nix { inherit pkgs; });
  programs.zsh = (import ./zsh.nix { inherit pkgs; });

  home.stateVersion = "24.05";
}
