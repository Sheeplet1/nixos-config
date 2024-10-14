{ config, pkgs, ... }:

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

	programs.tmux = (import ./tmux.nix { inherit pkgs; });
    programs.git = (import ./git.nix { inherit pkgs; });
    programs.alacritty = (import ./alacritty.nix { inherit pkgs; });
	programs.zsh = (import ./zsh.nix { inherit pkgs; });

	# In case Alacritty does not launch, swap to foot
	# programs.foot = {
	# 	enable = true;
	# };


	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			"$mod" = "SUPER";
			bind = [
				"$mod, RETURN, exec, alacritty"
				"$mod, Q, killactive"
				"$mod, M, exit"
				"$mod, left, movefocus, l"
				"$mod, right, movefocus, r"
				"$mod, up, movefocus, up"
				"$mod, down, movefocus, down"
			]
			++ (
				builtins.concatLists (builtins.genList(i:
						let ws = i + 1;
						in [
							"$mod, code:1${toString i}, workspace, ${toString ws}"
							"$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
						]
					)
				10)
			);
		};
	};


	home.stateVersion = "24.05";

}
