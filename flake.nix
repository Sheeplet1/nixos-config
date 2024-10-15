{
  description = "Top-level NixOS Flake";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs

  inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};

	# TODO: add zen-browser to system packages
	zen-browser.url = "github:MarceColl/zen-browser-flake";

	minimal-tmux = {
		url = "github:niksingh710/minimal-tmux-status";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
	nixosConfigurations.aarch64 = nixpkgs.lib.nixosSystem{
		system = "aarch64-linux";
		specialArgs = { inherit inputs; };
		modules = [
			./configuration.nix
			./hardware/aarch64/extra-configuration.nix
			./hardware/aarch64/hardware-configuration.nix

			inputs.home-manager.nixosModules.default

			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
				home-manager.users.anthonyd = import ./home/home.nix;
			}

		];
	};
    nixosConfigurations.linux = nixpkgs.lib.nixosSystem{
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
            ./configuration.nix
	    ./hardware/x86_64-desktop/extra_configuration.nix

            inputs.home-manager.nixosModules.default

            home-manager.nixosModules.home-manager {
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.users.anthonyd = import ./home/home.nix;
            }
        ];
    };
  };
}
