{ pkgs, config, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {
  programs = {
    tmux = {
      enable = true;

      shortcut = "y";
      escapeTime = 10;
      terminal = "tmux-256color";
      sensibleOnTop = false;

      extraConfig = ''
        # Open panes in current dir
        bind C new-window -c "#{pane_current_path}"
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded..."
        bind l select-layout main-horizontal
        unbind '"'
        unbind %

        # Enable mouse control (clickable windows, panes, resizable panes)
        set -g mouse on

        # Switch window with alt num
        bind-key -n M-1 select-window -t 0
        bind-key -n M-2 select-window -t 1
        bind-key -n M-3 select-window -t 2
        bind-key -n M-4 select-window -t 3
        bind-key -n M-5 select-window -t 4
        bind-key -n M-6 select-window -t 5
        bind-key -n M-7 select-window -t 6
        bind-key -n M-8 select-window -t 7
        bind-key -n M-9 select-window -t 8
        bind-key -n C-k select-pane -U
        bind-key -n C-j select-pane -D
        bind-key -n C-h select-pane -L
        bind-key -n C-l select-pane -R

        # Kill session on close
        set-option -g detach-on-destroy off

        # Automatically set window title
        set-window-option -g automatic-rename on
        set-option -g set-titles on


        # Neovim settings
        set-option -sa terminal-overrides 'alacritty:RGB'
        # Undercurl
        set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
        set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

        # Quickly edit todo list
        bind-key t split-window -h "nvim ~/todo.md"

        # Quickly open btm
        bind-key b split-window -h "btm"

        # Open dotfiles
        bind-key d split-window -h "nvim ~/Repos/dotfiles"

        # Watch temps
        bind-key T split-window -h "watch -n .5 'sensors | grep coretemp -A 5'"

        set -g mode-style "fg=${vim.blue},bg=${vim.fg_gutter}"

        set -g message-style "fg=${vim.blue},bg=${vim.fg_gutter}"
        set -g message-command-style "fg=${vim.blue},bg=${vim.fg_gutter}"

        set -g pane-border-style "fg=${vim.fg_gutter}"
        set -g pane-active-border-style "fg=${vim.blue}"

        set -g status "on"
        set -g status-justify "left"

        set -g status-style "fg=${vim.blue},bg=${vim.bg}"

        set -g status-left-length "100"
        set -g status-right-length "100"

        set -g status-left-style NONE
        set -g status-right-style NONE

        set -g status-left "#[fg=${bright.black},bg=${vim.blue},bold] #S #[fg=${bright.blue},bg=${vim.bg},nobold,nounderscore,noitalics]"
        set -g status-right "#[fg=${vim.bg},bg=${vim.bg},nobold,nounderscore,noitalics]#[fg=${vim.blue},bg=${vim.bg}] #{prefix_highlight} #[fg=${vim.fg_gutter},bg=${vim.bg},nobold,nounderscore,noitalics]#[fg=${bright.blue},bg=${vim.fg_gutter}] %Y-%m-%d  %I:%M %p #[fg=${bright.blue},bg=${vim.fg_gutter},nobold,nounderscore,noitalics]#[fg=${bright.black},bg=${bright.blue},bold] #h "

        setw -g window-status-activity-style "underscore,fg=${vim.fg_dark},bg=${vim.bg}"
        setw -g window-status-separator ""
        setw -g window-status-style "NONE,fg=${vim.fg_dark},bg=${vim.bg}"
        setw -g window-status-format "#[fg=${vim.bg},bg=${vim.bg},nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=${vim.bg},bg=${vim.bg},nobold,nounderscore,noitalics]"
        setw -g window-status-current-format "#[fg=${vim.bg},bg=${vim.fg_gutter},nobold,nounderscore,noitalics]#[fg=${vim.blue},bg=${vim.fg_gutter},bold] #I  #W #F #[fg=${vim.fg_gutter},bg=${vim.bg},nobold,nounderscore,noitalics]"
      '';
    };
  };
}
