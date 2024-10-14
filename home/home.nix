{ inputs, config, pkgs, ... }:

{
	programs.home-manager.enable = true;
	home.username = "anthony";
	home.homeDirectory = "/home/anthony";

	home.packages = with pkgs; [
		# archives
		zip
		unzip

		# utils
		ripgrep
		fzf
		jq

		# misc
		tree
	];

	programs.tmux = (import ./tmux.nix { inherit inputs pkgs; });
	programs.git = (import ./git.nix { inherit pkgs; });
	programs.alacritty = (import ./alacritty.nix { inherit pkgs; });
	programs.zsh = (import ./zsh.nix { inherit pkgs; });
	programs.zoxide = (import ./zoxide.nix { inherit pkgs; });

	# In case Alacritty does not launch, swap to foot
	# programs.foot = {
	# 	enable = true;
	# };

	wayland.windowManager.hyprland = (import ./hyprland.nix { inherit pkgs; });


	home.stateVersion = "24.05";
}
