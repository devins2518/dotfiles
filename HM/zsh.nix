{ pkgs, config, lib, inputs, ... }:

{
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
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue,underline"
      '';

      initExtraFirst = ''
        bunnyfetch
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';

      plugins = [
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
          file = "zsh-syntax-highlighting.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zdharma";
            repo = "fast-syntax-highlighting";
            rev = "817916dfa907d179f0d46d8de355e883cf67bd97";
            sha256 = "0qimb90655hkm64mjqcn48kqq38cbfxlfhs324cbdi9gqpdi6q4b";
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
}
