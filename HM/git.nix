{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
      key = "4F6C4997D9719DBF";
    };

    settings = {
      user = {
        name = "Devin Singh";
        email = "drsingh2518@icloud.com";
      };

      aliases = {
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
        cush = "!git commit && git push";
      };

      delta = {
        enable = true;
        options = {
          side-by-side = true;
          line-numbers = true;
          features = "arctic-fox";
        };
      };

      extraConfig = {
        pull = {
          rebase = true;
        };
        advice = {
          #  detachedHead = false;
        };
        init = {
          defaultBranch = "main";
        };
        rebase = {
          abbreviateCommands = true;
        };
        pack = {
          threads = 0;
        };
        core = {
          editor = "nvim";
        };
        credential = {
          helper = "store --file ~/.git-credentials";
        };
        diff = {
          colorMoved = "zebra";
        };
      };

    };

    lfs.enable = true;

    ignores = [
      "shell.nix"
      ".DS_Store"
      ".gyro"
      "gyro.lock"
      ".direnv"
      "_build"
      "_opam"
      "out"
      "zig-cache"
      "zig-out"
      ".envrc"
      "*.dSYM"
      "*.o"
    ];

  };
}
