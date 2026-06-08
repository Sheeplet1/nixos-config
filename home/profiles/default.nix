# Basic home-manager profile that is shared across all profiles. No desktop
# environment is set here.
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  cfg = config.enablePackages;

  nvimConfigLocation = "${config.home.homeDirectory}/nix/home/neovim/nvim";
  scriptsLocation = "${config.home.homeDirectory}/nix/home/scripts";
in
{
  options.enablePackages = {
    # Enabled by default
    homelab.enable = (lib.mkEnableOption "Enable homelab packages") // {
      default = true;
    };
    aiTooling.enable = (lib.mkEnableOption "Enable AI tooling packages") // {
      default = true;
    };
    nixDevelopment.enable = (lib.mkEnableOption "Enable Nix development packages") // {
      default = true;
    };

    # Disabled by default
    shellDevelopment.enable = lib.mkEnableOption "Enable shell development packages";
    cppDevelopment.enable = lib.mkEnableOption "Enable C++ development packages";
    rustDevelopment.enable = lib.mkEnableOption "Enable Rust development packages";
    goDevelopment.enable = lib.mkEnableOption "Enable Go development packages";
    typescriptDevelopment.enable = lib.mkEnableOption "Enable TypeScript development packages";
    zigDevelopment.enable = lib.mkEnableOption "Enable Zig development packages";
  };

  config = {
    home.username = if isDarwin then "anthonydo" else "anthonyd";
    home.homeDirectory = if isDarwin then "/Users/anthonydo" else "/home/anthonyd";

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
      EDITOR = "nvim";
      NIX_NEOVIM = "1"; # Disabling Mason on NixOS

      # API Keys
      # OPENAI_API_KEY = "op://Personal/openapi-personal/credential";
      # GEMINI_API_KEY = "op://Personal/gemini-personal/credential";
    };

    home.packages =
      with pkgs;
      [
        _1password-cli

        # General packages
        bat
        curl
        eza
        fd
        gcc
        gh
        jq
        jujutsu
        lazygit
        meslo-lgs-nf
        python3
        ripgrep
        stow
        tree
        tree-sitter
        unzip
        uv
        wget
        yazi
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
            # Apple silicon is not supported. We use Instruments instead.
            valgrind
          ]
      )
      ++ lib.optionals cfg.homelab.enable [
        argocd
        kubernetes-helm
        helmfile
        kubeseal
        kubectl
        qrencode
        wireguard-tools
      ]
      ++ lib.optionals cfg.aiTooling.enable [
        claude-code
        codex
      ]
      ++ lib.optionals cfg.shellDevelopment.enable [
        bash-language-server
        shellcheck
        shfmt
      ]
      ++ lib.optionals cfg.cppDevelopment.enable [
        cppcheck
        clang-tools
        clang-analyzer
        gtest

        # Profiling tools
        gdb
        lldb

        # Build
        cmake
        ninja
      ]
      ++ lib.optionals cfg.rustDevelopment.enable [
        clippy
        cargo
        rust-analyzer
        rustc
        rustfmt
      ]
      ++ lib.optionals cfg.typescriptDevelopment.enable [
        biome
        bun
        nodejs
        pnpm
        typescript
        typescript-language-server
      ]
      ++ lib.optionals cfg.zigDevelopment.enable [
        zig
        zls
      ]
      ++ lib.optionals cfg.nixDevelopment.enable [
        nixd
        nixfmt
      ]
      ++ lib.optionals cfg.goDevelopment.enable [
        go
        gopls
      ];

    home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
    home.file.".scripts/".source = config.lib.file.mkOutOfStoreSymlink scriptsLocation;
    home.file.".config/jj/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home/jujutsu.toml";

    xdg.configFile."electron-flags.conf".source = ./electron-flags.conf;

    programs = {
      home-manager.enable = true;
      git = import ../git.nix { inherit pkgs; };
      fish = import ../fish.nix { inherit pkgs; };
      fzf = import ../fzf.nix { inherit pkgs; };
      neovim = import ../neovim/neovim.nix { inherit inputs pkgs; };
      # starship = import ../starship.nix { inherit pkgs; };
      tmux = import ../tmux.nix { inherit inputs pkgs; };
      zoxide = import ../zoxide.nix { inherit pkgs; };
      # zsh = import ../zsh.nix { inherit pkgs config; };
      # vim = import ../vim.nix { inherit pkgs; };
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    };

    home.stateVersion = "24.11";
  };
}
