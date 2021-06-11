{ pkgs, config, ... }:

{
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
        unbind '"'
        unbind %

        # vim-like pane switching
        bind -r k select-pane -U 
        bind -r j select-pane -D 
        bind -r h select-pane -L 
        bind -r l select-pane -R 

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

        # Kill session on close
        set-option -g detach-on-destroy off

        # Automatically set window title
        set-window-option -g automatic-rename on
        set-option -g set-titles on

        # Use 24 bit color
        set -g status-bg color00
        set -g status-fg color04

        # Neovim settings
        set-option -sa terminal-overrides 'alacritty:RGB'

        # Quickly edit todo list
        bind-key t split-window -h "nvim ~/todo.md"

        # Quickly open btm
        bind-key b split-window -h "btm"

        # Open dotfiles
        bind-key d split-window -h "nvim ~/Repos/dotfiles"

        # Watch temps
        bind-key T split-window -h "watch -n .5 'sensors | grep coretemp -A 5'"
      '';
    };
  };
}
