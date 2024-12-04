{ inputs, pkgs, ... }:
let
  tokyo-night = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tokyo-night";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "janoamaral";
      repo = "tokyo-night-tmux";
      rev = "master";
      sha256 = "sha256-3rMYYzzSS2jaAMLjcQoKreE0oo4VWF9dZgDtABCUOtY=";
    };
  };
in
{
  enable = true;
  baseIndex = 1;
  disableConfirmationPrompt = true;
  keyMode = "vi";
  terminal = "screen-256color";
  escapeTime = 10;
  newSession = true;
  prefix = "C-a";
  shell = "${pkgs.zsh}/bin/zsh";

  plugins = with pkgs.tmuxPlugins; [
    vim-tmux-navigator
    yank
    resurrect
    copycat
    continuum
    # {
    #   plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
    #   extraConfig = ''
    #     set -g @minimal-tmux-justify "left"
    #     set -g @minimal-tmux-indicator false
    #   '';
    # }
    tokyo-night
  ];

  extraConfig = ''
    set -g mouse on
    set -g status-interval 5

    set-option -sa terminal-overrides ",xterm-256color:RGB"

    set -g status-style 'bg=#333333 fg=#5eacd3'

    # Start windows and panes at 1, not 0
    set -g base-index 1
    setw -g pane-base-index 1
    set-window-option -g pane-base-index 1
    set-option -g renumber-windows on

    # auto rename windows to reflect current process
    setw -g automatic-rename on 

    # renumber windows when a window is closed
    set -g renumber-windows on

    ################################# key rebinds ##################################
    # Pane selections
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    # Vertical Split rebind
    unbind %
    bind | split-window -h -c "#{pane_current_path}"

    # Horizontal Split rebind
    unbind '"'
    bind - split-window -v -c "#{pane_current_path}"

    # Refresh tmux source configuration 
    unbind ]
    bind ] source-file ~/.config/tmux/tmux.conf

    # Bind vim keys to resize panels
    bind -r j resize-pane -D 5
    bind -r k resize-pane -U 5
    bind -r l resize-pane -R 5
    bind -r h resize-pane -L 5
    bind -r m resize-pane -Z # maximise panels
    bind > swap-pane -D       # swap current pane with the next one
    bind < swap-pane -U       # swap current pane with the previous one

    # Rebinding copying terminal output
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

    # Tmux Sessionizer 
    bind-key -r f run-shell "tmux neww ~/.scripts/tmux-sessionizer"
    bind-key -r m run-shell "~/.scripts/tmux-windownizer"

    # Switch windows
    bind-key -n S-Left previous-window
    bind-key -n S-Right next-window

    # Using vim keybinds to switch windows
    bind-key -n M-H previous-window
    bind-key -n M-L next-window

    set -g @tokyo-night-tmux_window_id_style hsquare 
    set -g @tokyo-night-tmux_show_datetime 0
    set -g @tokyo-night-tmux_show_path 0

    run-shell ${tokyo-night}/share/tmux-plugins/tokyo-night/tokyo-night.tmux
  '';
}
