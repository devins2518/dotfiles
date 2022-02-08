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
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374"

        [[ ! -r ${home}/.opam/opam-init/init.zsh ]] || source ${home}/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
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
            rev = "ed901ab5f741fb3b9076022ec0c1ba1220beb0d7";
            sha256 = "sha256-CKky9u0bnCme/jGCqkxD4YaKYwvgmdWoBE0SGiYM1MI=";
          };
        }
        {
          name = "zsh-powerlevel10k";
          file = "powerlevel10k.zsh-theme";
          src = pkgs.fetchFromGitHub {
            owner = "romkatv";
            repo = "powerlevel10k";
            rev = "v1.14.6";
            sha256 = "1z6xipd7bgq7fc03x9j2dmg3yv59xyjf4ic5f1l6l6pw7w3q4sq7";
          };
        }
        {
          name = "fast-syntax-highlighting";
          file = "fast-syntax-highlighting.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zdharma-continuum";
            repo = "fast-syntax-highlighting";
            rev = "585c089968caa1c904cbe926ff04a1be9e3d8f42";
            sha256 = "sha256-x+4C2u03RueNo6/ZXsueqmYoPIpDHnKAZXP5IiKsidE=";
          };
        }
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.2.0";
            sha256 = "1gfyrgn23zpwv1vj37gf28hf5z0ka0w5qm6286a7qixwv7ijnrx9";
          };
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.4.0";
            sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
          };
        }
      ];
    };
  };

  # Prevent `last login` message from being shown
  home = lib.mkIf pkgs.stdenv.isDarwin { file.".hushlogin".text = ""; };
}
