# Basic home-manager profile that is shared across all profiles. No desktop 
# environment is set here.
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
    bat
    cargo
    curl
    eza
    fd
    gcc
    go
    jq
    lazygit
    meslo-lgs-nf
    nixfmt-rfc-style
    nodejs
    python3
    ripgrep
    rustc
    stow
    tree
    unzip
    wget
    zip
    zsh-powerlevel10k
  ];

  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
  home.file.".scripts/".source = config.lib.file.mkOutOfStoreSymlink scriptsLocation;

  xdg.configFile."electron-flags.conf".source = ./electron-flags.conf;

  programs.alacritty = (import ../alacritty.nix { inherit pkgs; });
  programs.git = (import ../git.nix { inherit pkgs; });
  programs.fzf = (import ../fzf.nix { inherit pkgs; });
  programs.neovim = (import ../neovim/neovim.nix { inherit pkgs; });
  # programs.starship = (import ../starship.nix { inherit pkgs; });
  programs.tmux = (import ../tmux.nix { inherit inputs pkgs; });
  programs.zoxide = (import ../zoxide.nix { inherit pkgs; });
  programs.zsh = (import ../zsh.nix { inherit pkgs; });

  home.stateVersion = "24.05";
}
