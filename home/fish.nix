{
  inputs,
  lib,
  pkgs,
  ...
}:
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
  interactiveShellInit = lib.strings.concatStrings (
    lib.strings.intersperse "\n" [
      "source ${inputs.theme-bobthefish}/functions/fish_prompt.fish"
      "source ${inputs.theme-bobthefish}/functions/fish_right_prompt.fish"
      "source ${inputs.theme-bobthefish}/functions/fish_title.fish"
      (builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]
  );
  plugins =
    map
      (n: {
        name = n;
        src = inputs.${n};
      })
      [
        "fish-fzf"
        "fish-foreign-env"
        "theme-bobthefish"
      ];
}
