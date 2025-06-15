# Basic home-manager profile that is shared across all profiles. No desktop
# environment is set here.
{
  inputs,
  config,
  pkgs,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;

  nvimConfigLocation = "${config.home.homeDirectory}/nix/home/neovim/nvim";
  scriptsLocation = "${config.home.homeDirectory}/nix/home/scripts";
in
{
  home.username = if isDarwin then "anthonydo" else "anthonyd";
  home.homeDirectory = if isDarwin then "/Users/anthonydo" else "/home/anthonyd";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
    EDITOR = "nvim";
    NIX_NEOVIM = "1"; # Disabling Mason on NixOS
  };

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
    sshs
    stow
    tree
    unzip
    wget
    zig
    zip
    zsh-powerlevel10k
  ];

  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
  home.file.".scripts/".source = config.lib.file.mkOutOfStoreSymlink scriptsLocation;

  xdg.configFile."electron-flags.conf".source = ./electron-flags.conf;

  programs = {
    home-manager.enable = true;
    git = import ../git.nix { inherit pkgs; };
    fzf = import ../fzf.nix { inherit pkgs; };
    neovim = import ../neovim/neovim.nix { inherit pkgs; };
    # starship = import ../starship.nix { inherit pkgs; };
    tmux = import ../tmux.nix { inherit inputs pkgs; };
    zoxide = import ../zoxide.nix { inherit pkgs; };
    zsh = import ../zsh.nix { inherit pkgs; };
    vim = import ../vim.nix { inherit pkgs; };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home.stateVersion = "24.11";
}
