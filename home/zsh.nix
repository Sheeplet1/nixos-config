{ pkgs, ... }:
{
	enable = true;
    history.size = 10000;
    shellAliases = {
        gs = "git status";
        gcl = "git clone";
        ga = "git add";
        gaa = "git add --all";
        gc = "git commit -m";
        gd = "git diff";
        c = "clear";
        ls = "ls --color";
        vim = "nvim";
    };
    # TODO: Add completion styling with fzf
    initExtra = ''
        [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
    '';

    plugins = [
        {
            name = "zsh-autosuggestions";
            src = pkgs.zsh-autosuggestions;
            file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
        {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
            name = "zsh-completions";
            src = pkgs.zsh-completions;
            file = "share/zsh-completions/zsh-completions.zsh";
        }
        {
            name = "zsh-syntax-highlighting";
            src = pkgs.zsh-syntax-highlighting;
            file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
        {
            name = "fzf-tab";
            src = pkgs.zsh-fzf-tab;
            file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
    ];
}
