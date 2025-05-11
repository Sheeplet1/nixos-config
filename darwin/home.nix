{
  inputs,
  config,
  pkgs,
  ...
}:
let
  nvimConfigLocation = "${config.home.homeDirectory}/nix/home/neovim/nvim";
  scriptsLocation = "${config.home.homeDirectory}/nix/home/scripts";
in
{
  programs.home-manager.enable = true;

  xdg.enable = true;

  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
  home.file.".scripts/".source = config.lib.file.mkOutOfStoreSymlink scriptsLocation;

  programs.aerospace = (import ./home/aerospace.nix { inherit pkgs; });
  programs.git = (import ../home/git.nix { inherit pkgs; });

  # Cannot build ghostty through Nix on Darwin yet. See the below issue:
  # https://github.com/NixOS/nixpkgs/issues/388984
  # programs.ghostty = (import ../home/ghostty.nix { inherit pkgs; });

  programs.fzf = (import ../home/fzf.nix { inherit pkgs; });
  programs.neovim = (import ../home/neovim/neovim.nix { inherit pkgs; });
  programs.spotify-player = (import ../home/spotify-player.nix { inherit pkgs; });
  programs.tmux = (import ../home/tmux.nix { inherit inputs pkgs; });
  programs.zoxide = (import ../home/zoxide.nix { inherit pkgs; });
  programs.zsh = (import ../home/zsh.nix { inherit pkgs; });
  programs.vim = (import ../home/vim.nix { inherit pkgs; });

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.stateVersion = "24.11";
}
