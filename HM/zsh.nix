{ pkgs, config, lib, inputs, ... }:

let
  nix-command =
    if pkgs.stdenv.isDarwin then "darwin-rebuild" else "sudo nixos-rebuild";
  home = if pkgs.stdenv.isDarwin then "/Users/devin" else "/home/devin";
in {
  programs = {
    zsh = {
      enable = true;

      history = {
        path = ".zsh/HISTFILE";
        size = 2000;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        share = false;
      };

      initExtra = ''
        # Fuzzy finding
        zstyle ':completion:*' matcher-list "" \
          'm:{a-z\-}={A-Z\_}' \
          'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
          'r:|?=** m:{a-z\-}={A-Z\_}'
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        function top-dir() {
            (du -ah $1 | sort -n -r | head -n $2) 2>/dev/null
        }
        function search() {
            (find $1 -name "*$2*") 2>/dev/null
        }
        export EDITOR=nvim
        export VISUAL=nvim
        export PATH=$PATH:~/.local/bin
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374"

        [[ ! -r ${home}/.opam/opam-init/init.zsh ]] || source ${home}/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

        eval "$(direnv hook zsh)"
      '';

      initExtraFirst = ''
        bunnyfetch
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';

      shellAliases = {
        nshell = "nix-shell";
        ls = "ls -l --color=always -H";
        fupdate =
          "${nix-command} switch --flake '${config.home.homeDirectory}/Repos/dotfiles/#'";
        fclup =
          "${nix-command} nixos-rebuild switch --flake '${config.home.homeDirectory}/Repos/dotfiles/#' && sudo nix-collect-garbage -d";
        grep = "rg";
        g = "gyro";
        update-zig =
          "zigup master --install-dir /home/devin/.zigup --path-link /home/devin/bin/zig";
        mbuild = "meson compile -C build";
        mtest = "meson test -C build";
      };

      plugins = [
        {
          name = "nix-zsh-completions";
          file = "nix-zsh-completions.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "spwhitt";
            repo = "nix-zsh-completions";
            rev = "468d8cf752a62b877eba1a196fbbebb4ce4ebb6f";
            sha256 = "sha256-TWgo56l+FBXssOYWlAfJ5j4pOHNmontOEolcGdihIJs=";
          };
        }
        {
          name = "zsh-completions";
          file = "zsh-completions.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "clarketm";
            repo = "zsh-completions";
            rev = "82db8e4056c049dc9885979ae6968bf8b244e5d3";
            sha256 = "sha256-WajQx0ZrjrmGtZ2uvixGhwVslYvEUrxANrpvl3whjp8=";
          };
        }
        {
          name = "zsh-powerlevel10k";
          file = "powerlevel10k.zsh-theme";
          src = pkgs.fetchFromGitHub {
            owner = "romkatv";
            repo = "powerlevel10k";
            rev = "6b128d48d675509666ff222eb08922cc6a7b6753";
            sha256 = "sha256-ZDtreMWnt83HwVfLOds/LbvIppIZtjsY0WFa3mpqGHM=";
          };
        }
        {
          name = "fast-syntax-highlighting";
          file = "fast-syntax-highlighting.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zdharma-continuum";
            repo = "fast-syntax-highlighting";
            rev = "370106d95d1486c3d0d894d1a2a823ce9b0fcdb3";
            sha256 = "sha256-OvF9kB+EWsSue0XAJs4nODNxKuufKWpAK6Ya3F3iWp0=";
          };
        }
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "af6f8a266ea1875b9a3e86e14796cadbe1cfbf08";
            sha256 = "sha256-BjgMhILEL/qdgfno4LR64LSB8n9pC9R+gG7IQWwgyfQ=";
          };
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "a411ef3e0992d4839f0732ebeb9823024afaaaa8";
            sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
      ];
    };
  };

  # Prevent `last login` message from being shown
  home = lib.mkIf pkgs.stdenv.isDarwin { file.".hushlogin".text = ""; };
}
