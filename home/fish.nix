{ config, pkgs, ... }:
let
  fish_prompt_location = "${config.home.homeDirectory}/nix/home/fish_prompt.fish";
in
{
  enable = true;
  shellAliases = {
    cat = "bat";
    # ls = "ls --color";
    ls = "exa";

    # Git aliases
    gs = "git status";
    gcl = "git clone";
    ga = "git add";
    gaa = "git add --all";
    gc = "git commit -m";
    gd = "git diff";
    gp = "git push";
    gl = "git log --graph --decorate --pretty=oneline --abbrev-commit --all";

    # jj aliases
    jd = "jj desc";
    jdf = "hunk diff";
    jgf = "jj git fetch";
    jn = "jj new";
    jp = "jj git push";
    js = "jj st";
    jt = "jj tug";

    c = "clear";
    cd = "z";
    k = "kubectl";
  };

  shellInit = ''
    #------------------------------------------------------------------------
    # THEME
    #------------------------------------------------------------------------

    # bobthefish theme
    set -g theme_color_scheme dracula
    set -g theme_newline_cursor no
    set -g theme_nerd_fonts yes 
    set -g theme_powerline_fonts yes

    #------------------------------------------------------------------------
    # TMUX
    #------------------------------------------------------------------------

    # Tmux attach session or start new
    # if command -v tmux >/dev/null 2>&1
    #     and status is-interactive
    #     and not set -q TMUX
    #     and not string match -rq 'screen|tmux' -- "$TERM"
    #
    #     tmux attach 2>/dev/null; or tmux
    # end
  '';

  interactiveShellInit = ''
    # source ${pkgs.fishPlugins.bobthefish.src}/functions/fish_prompt.fish
    source ${fish_prompt_location}
    source ${pkgs.fishPlugins.bobthefish.src}/functions/fish_right_prompt.fish
    source ${pkgs.fishPlugins.bobthefish.src}/functions/fish_title.fish
  '';

  plugins = [
    {
      name = "z";
      src = pkgs.fishPlugins.z.src;
    }
    {
      name = "fzf-fish";
      src = pkgs.fishPlugins.fzf-fish.src;
    }
    {
      name = "bobthefisher";
      src = pkgs.fishPlugins.bobthefisher.src;
    }
    # {
    #   name = "pure";
    #   src = pkgs.fishPlugins.pure.src;
    # }
    {
      name = "transient-fish";
      src = pkgs.fishPlugins.transient-fish.src;
    }
  ];
}
