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

        bind -r k select-pane -U
        bind -r j select-pane -D
        bind -r h select-pane -L
        bind -r l select-pane -R

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

        # Kill session on close
        set-option -g detach-on-destroy off

        # Automatically set window title
        set-window-option -g automatic-rename on
        set-option -g set-titles on


        # Neovim settings
        set-option -sa terminal-overrides 'foot:RGB'
        set-option -g default-terminal "tmux-256color"
        set-option -g focus-events on

        # Undercurl
        set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm' # undercurl support
        set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m' # underscore colours - needs tmux-3.0

        # Quickly edit todo list
        bind-key t split-window -h "nvim ~/todo.md"

        # Quickly open btm
        bind-key b split-window -h "btm"

        # Open dotfiles
        bind-key d split-window -h "nvim ~/Repos/dotfiles"

        # Better split switching
        bind -n M-l select-pane -L
        bind -n M-h select-pane -R
        bind -n M-k select-pane -U
        bind -n M-j select-pane -D

        # Gruvbox status
        set-option -g status "on"

        # default statusbar color
        set-option -g status-style bg=colour237,fg=colour223 # bg=bg1, fg=fg1

        # default window title colors
        set-window-option -g window-status-style bg=colour214,fg=colour237 # bg=yellow, fg=bg1

        # default window with an activity alert
        set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3

        # active window title colors
        set-window-option -g window-status-current-style bg=red,fg=colour237 # fg=bg1

        # pane border
        set-option -g pane-active-border-style fg=colour250 #fg2
        set-option -g pane-border-style fg=colour237 #bg1

        # message infos
        set-option -g message-style bg=colour239,fg=colour223 # bg=bg2, fg=fg1

        # writing commands inactive
        set-option -g message-command-style bg=colour239,fg=colour223 # bg=fg3, fg=bg1

        # pane number display
        set-option -g display-panes-active-colour colour250 #fg2
        set-option -g display-panes-colour colour237 #bg1

        # clock
        set-window-option -g clock-mode-colour colour109 #blue

        # bell
        set-window-option -g window-status-bell-style bg=colour167,fg=colour235 # bg=red, fg=bg

        ## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
        set-option -g status-justify "left"
        set-option -g status-left-style none
        set-option -g status-left-length "80"
        set-option -g status-right-style none
        set-option -g status-right-length "80"
        set-window-option -g window-status-separator ""

        set-option -g status-left "#[bg=colour241,fg=colour248] #S #[bg=colour237,fg=colour241,nobold,noitalics,nounderscore]"
        set-option -g status-right "#[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] %Y-%m-%d %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #h "

        set-window-option -g window-status-current-format "#[bg=colour214,fg=colour237,nobold,noitalics,nounderscore]#[bg=colour214,fg=colour239] #I#[bg=colour214,fg=colour239,bold] #W#{?window_zoomed_flag,*Z,} #[bg=colour237,fg=colour214,nobold,noitalics,nounderscore]"
        set-window-option -g window-status-format "#[bg=colour239,fg=colour237,noitalics]#[bg=colour239,fg=colour223] #I#[bg=colour239,fg=colour223] #W #[bg=colour237,fg=colour239,noitalics]"
              '';
    };
  };
}
