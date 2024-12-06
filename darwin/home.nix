{ inputs, config, pkgs, ... }:
let
	nvimConfigLocation = "${config.home.homeDirectory}/nix/home/neovim/nvim";
    scriptsLocation = "${config.home.homeDirectory}/nix/home/scripts";
in
{
	programs.home-manager.enable = true;

	xdg.enable = true;

	home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
    home.file.".scripts/".source = config.lib.file.mkOutOfStoreSymlink scriptsLocation;

    programs.alacritty = (import ../home/alacritty.nix { inherit pkgs; });
    programs.git = (import ../home/git.nix { inherit pkgs; });
    programs.fzf = (import ../home/fzf.nix { inherit pkgs; });
    programs.neovim = (import ../home/neovim/neovim.nix { inherit pkgs; });
    programs.tmux = (import ../home/tmux.nix { inherit inputs pkgs; });
    programs.zoxide = (import ../home/zoxide.nix { inherit pkgs; });
    programs.zsh = (import ../home/zsh.nix { inherit pkgs; });

    programs.direnv = {
	enable = true;
	enableZshIntegration = true;
	nix-direnv.enable = true;
    };

    home.stateVersion = "24.11";
}
