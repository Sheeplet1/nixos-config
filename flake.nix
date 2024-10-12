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
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
	nixosConfigurations.anthony = nixpkgs.lib.nixosSystem{
		system = "aarch64-linux";
		modules = [
			./configuration.nix

			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
				home-manager.users.anthony = import ./home/home.nix;
				# home-manager.backupFileExtension = 'backup';
			}

		];
	};

	formatter.anthony = "nixfmt";
  };

}
