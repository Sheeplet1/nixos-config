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

	programs.git = {
		enable = true;
		userName = "Anthony";
		userEmail = "42196548+Sheeplet1@users.noreply.github.com";
		extraConfig = {
			init.defaultBranch = "main";
		};
	};

	programs.alacritty = {
		enable = true;
		settings = {
			env.TERM = "xterm-256color";
			font = {
				size = 18;
				# draw_bold_text_with_bright_colors = true;
			};
			selection.save_to_clipboard = true;
		};
	};

	programs.foot = {
		enable = true;
	};

	programs.zsh = {
		enable = true;
		sessionVariables = {
			LIBGL_ALWAYS_SOFTWARE = 1;
		};
	};

	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			"$mod" = "SUPER";
			bind = [
				"$mod, F, exec, foot"
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
