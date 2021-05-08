{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "tmux-256color";

      window = {
        decorations = "none";
        padding = {
          x = 10;
          y = 10;
        };
      };

      font = {
        #ligatures = true;
        size = 11;
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Medium";
        };
        bold = {
          family = "FiraCode Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "Iosevka Nerd Font Mono";
          style = "Bold Italic";
        };
        bold_italic = {
          family = "Iosevka Nerd Font Mono";
          style = "Bold Italic";
        };
      };

      colors = {
        primary = {
          background = "#0F2123";
          foreground = "#F8F8F2";
        };
        normal = {
          black = "#03130D";
          red = "#D75656";
          green = "#5DBE54";
          yellow = "#E4E65C";
          blue = "#5F7BFF";
          magenta = "#DD78AE";
          cyan = "#32CBCD";
          white = "#FFE5EB";
        };
        bright = {
          black = "#698C8E";
          red = "#FF7F7F";
          green = "#82DD6D";
          yellow = "#FFF190";
          blue = "#90AFFF";
          magenta = "#EAA9CE";
          cyan = "#9CE6E7";
          white = "#FFF0F0";
        };
      };

      background_opacity = 0.8;

      shell = {
        program = "/run/current-system/sw/bin/zsh";
        args = [ "-l" "-c" "tmux new || tmux" ];
      };

    };
  };

  #home.file.".config/nvim".recursive = ./nvim;
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;

    vimAlias = true;
    withRuby = false;
    defaultEditor = true;

    #  plugins = [
    #    {
    #      plugin = packer-nvim
    #    };
    #  ];
  };
}

