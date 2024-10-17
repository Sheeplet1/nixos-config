{ inputs, config, pkgs, ... }:

{
	programs.home-manager.enable = true;
	home.username = "anthonyd";
	home.homeDirectory = "/home/anthonyd";

	home.sessionVariables = {
		NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
	};

	home.packages = with pkgs; [];

	programs.tmux = (import ./tmux.nix { inherit inputs pkgs; });
	programs.git = (import ./git.nix { inherit pkgs; });
	programs.alacritty = (import ./alacritty.nix { inherit pkgs; });
	programs.zsh = (import ./zsh.nix { inherit pkgs; });
	programs.zoxide = (import ./zoxide.nix { inherit pkgs; });
	# programs.waybar = (import ./waybar.nix { inherit pkgs; });

	# In case Alacritty does not launch, swap to foot
	# programs.foot = {
	# 	enable = true;
	# };

	wayland.windowManager.hyprland = (import ./hyprland.nix { inherit pkgs; });

	home.stateVersion = "24.05";
}
