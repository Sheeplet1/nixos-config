{
  # TODO: Eventually, need to clean up this flake and duplicated code
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

    # minimal-tmux = {
    #   url = "github:niksingh710/minimal-tmux-status";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    ags.url = "github:Aylur/ags";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    # alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    # Having rust-overlay lets us use nightly Rust with pre-built binaries.
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
    in
    {
      nixosConfigurations.aarch64 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./machines/vm-aarch64.nix

          (import ./overlays)

          home-manager.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.anthonyd = import ./home/profiles/default.nix;
          }
        ];
      };
      nixosConfigurations.linux = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./machines/desktop.nix

          (import ./overlays)

          home-manager.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.anthonyd = import ./home/profiles/desktop.nix;
          }
        ];
      };
    };
}
