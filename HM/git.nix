{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Devin Singh";
    userEmail = "drsingh2518@icloud.com";

    signing = {
      signByDefault = true;
      key = "4F6C4997D9719DBF";
    };
    aliases = {
      lg =
        "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
      cush = "!git commit && git push";
    };

    lfs.enable = true;

    ignores = [ "**/shell.nix" ];

    extraConfig = {
      pull = { rebase = true; };
      advice = {
        #  detachedHead = false;
      };
      init = { defaultBranch = "main"; };
      rebase = { abbreviateCommands = true; };
      pack = { threads = 0; };
      core = { editor = "nvim"; };
      credential = { helper = "store --file ~/.git-credentials"; };
      diff = { colorMoved = "zebra"; };
    };
  };
}
