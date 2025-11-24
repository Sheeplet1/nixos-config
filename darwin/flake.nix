{
  description = "Zen Darwin system flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
      ...
    }@inputs:
    let
      configuration =
        { pkgs, config, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          nixpkgs.config.allowUnfree = true;

          fonts.packages = with pkgs; [
            nerd-fonts.iosevka
            nerd-fonts.jetbrains-mono
          ];

          programs.fish.enable = true;
          users.users.anthonydo = {
            name = "anthonydo";
            home = "/Users/anthonydo";
            shell = pkgs.fish;
          };

          homebrew = {
            enable = true;
            brews = [
              "amp"
              "docker"
              "mas"
              "pngpaste"
              "xcodes"
              "xcode-build-server"
              "xcbeautify"
            ];
            caskArgs.no_quarantine = true;
            casks = [
              "aerospace"
              "betterdisplay"
              "claude-code"
              "discord"
              "displaylink"
              "flux-app"
              "ghostty"
              "iina"
              "microsoft-office"
              "obsidian"
              "orcaslicer"
              "1password"
              "rectangle"
              "ticktick"
              "the-unarchiver"
              "scroll-reverser"
              "spotify"
              "zen"
            ];
            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          system.primaryUser = "anthonydo";

          system.defaults = {
            dock.autohide = true;
            dock.show-recents = false;
            loginwindow.GuestEnabled = false;
            NSGlobalDomain.AppleInterfaceStyle = "Dark";
            NSGlobalDomain.KeyRepeat = 2;
            NSGlobalDomain.InitialKeyRepeat = 15;
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          security.pam.services.sudo_local = {
            enable = true;
            touchIdAuth = true;
            reattach = true;
          };

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          configuration

          (import ../overlays)

          # Nix Homebrew module
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true; # Apple Silicon only
              user = "anthonydo";
              # autoMigrate = true;
            };
          }

          #  Home-manager module
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.anthonydo = import ./home.nix;
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."mac".pkgs;
    };
}
