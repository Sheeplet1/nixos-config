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

  home.packages =
    with pkgs;
    [
      # Homelab packages
      argocd
      kubernetes-helm
      helmfile
      kubeseal
      kubectl

      # AI Packages
      claude-code
      codex

      # Streamyfin packages
      bun
      biome
      libyaml
      ruby

      bat
      cargo
      curl
      eza
      fd
      gcc
      go
      jq
      jujutsu
      lazygit
      meslo-lgs-nf
      nixd
      nixfmt-rfc-style
      nodePackages.nodejs
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
    ]
    ++ (
      if isDarwin then
        [
          cocoapods
        ]
      else
        [
          # Bitwarden CLI has a build failure on Darwin. See below issue:
          # https://github.com/NixOS/nixpkgs/issues/339576
          # Instead, we've install bitwarden-cli via Brew.
          bitwarden-cli
        ]
    );

  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
  home.file.".scripts/".source = config.lib.file.mkOutOfStoreSymlink scriptsLocation;
  home.file.".config/jj/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home/jujutsu.toml";

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
