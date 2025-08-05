{ pkgs, ... }:
{
  enable = true;
  history.size = 10000;
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

  initContent = ''
    [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}

    export PATH="$HOME/go/bin:$PATH"
    export PATH="$HOME/.local/share/../bin:$PATH"

    # Making sure that the correct config path is set for jj
    export JJ_CONFIG="$HOME/.config/jj/config.toml"

    # On darker backgorunds of the terminal, the autosuggestions can blend in 
    # completely, so we change the colour for readability.
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'

    # disable sort when completing `git checkout`
    zstyle ':completion:*:git-checkout:*' sort false

    # set descriptions format to enable group support
    # NOTE: don't use escape sequences here, fzf-tab will ignore them
    zstyle ':completion:*:descriptions' format '[%d]'

    # set list-colors to enable filename colorizing
    zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

    # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
    zstyle ':completion:*' menu no

    # preview directory's content with eza when completing cd
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:ls:*' fzf-preview 'cat $realpath'

    # switch group using `<` and `>`
    zstyle ':fzf-tab:*' switch-group '<' '>'

    # Case insensitive completion
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

    # Tmux attach session or start new
    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; 
    then
      tmux attach 2>/dev/null || tmux
    fi

    eval "$(direnv hook zsh)"

    # API Keys 
    # source $HOME/.scripts/bw.sh
    # export GEMINI_API_KEY=$(bw get password gemini-api-key)
    # export OPENAI_API_KEY=$(bw get password openai-api-key)
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
