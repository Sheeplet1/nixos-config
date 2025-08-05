{ pkgs, ... }:
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
    jf = "jj git fetch";
    jn = "jj new";
    jp = "jj git push";
    js = "jj st";
    jt = "jj tug";

    c = "clear";
    cd = "z";
    k = "kubectl";
    codex = "op run -- codex";
    gemini = "op run -- gemini";
  };

  shellInit = ''
    # bobthefish theme
    set -g theme_color_scheme dracula
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
    # {
    #   name = "bobthefish";
    #   src = pkgs.fishPlugins.bobthefish.src;
    # }
    {
      name = "pure";
      src = pkgs.fishPlugins.pure.src;
    }
    {
      name = "transient-fish";
      src = pkgs.fishPlugins.transient-fish.src;
    }
  ];
}
