{
  description = "Top-level NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    # Having rust-overlay lets us use nightly Rust with pre-built binaries.
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rex = {
      url = "https://pkgs.superlogical.com/rex/nix/snapshot.tar.gz";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      rex,
      ...
    }@inputs:
    let
    in
    {
      nixosConfigurations.linux = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./machines/desktop.nix

          # Import all overlays
          (import ./overlays)

          home-manager.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.anthonyd = import ./home/profiles/desktop.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [ stylix.homeModules.stylix ];
          }

          # Rex home-manager setup
          {
            # Persist rex server even when the user logs out
            users.users.anthonyd.linger = true;

            home-manager.users.anthonyd = {
              imports = [ rex.homeManagerModules.default ];
              programs = {
                rex.enable = true;
                ssh.enable = true;
              };
              services = {
                rex = {
                  enable = true;
                  tailscale = {
                    enable = true;
                    hostname = "anthonyd-dev";
                  };
                };
              };
            };
          }
        ];
      };
    };
}
