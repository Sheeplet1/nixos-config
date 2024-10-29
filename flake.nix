{
  description = "Top-level NixOS Flake";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:omarcresp/zen-browser-flake";

    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    ags.url = "github:Aylur/ags";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    # NOTE: Required for building blink-cmp (neovim plugin) since there was 
    # too many dependencies that needed to be built. Having rust-overlay lets 
    # us use nightly Rust with pre-built binaries.
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      alacritty-theme,
      home-manager,
      rust-overlay,
      ...
    }@inputs:
    let
    in
    {
      nixpkgs.overlays = [
        alacritty-theme.overlays.default
        rust-overlay.overlays.default
      ];

      nixosConfigurations.aarch64 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hardware/aarch64/configuration.nix
          ./hardware/aarch64/hardware-configuration.nix

          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = [
                alacritty-theme.overlays.default
                rust-overlay.overlays.default
              ];
              environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            }
          )

          home-manager.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.anthonyd = import ./home/common-home.nix;
          }

        ];
      };
      nixosConfigurations.linux = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hardware/x86_64-nvidia/configuration.nix
          ./hardware/x86_64-nvidia/hardware-configuration.nix

          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = [
                alacritty-theme.overlays.default
                rust-overlay.overlays.default
              ];
              environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            }
          )

          home-manager.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.anthonyd = import ./home/home.nix;
          }
        ];
      };
    };
}
