{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ git-lfs ];
  programs.git = {
    enable = true;

    userName = "Devin Singh";
    userEmail = "drsingh2518@icloud.com";

    signing = {
      signByDefault = true;
      key = null;
    };
    aliases = {
      lg =
        "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
      cush = "!git commit && git push";
    };

    extraConfig = {
      pull = { rebase = true; };
      advice = {
        #  detachedHead = false;
      };
      init = { defaultBranch = "master"; };
      rebase = { abbreviateCommands = true; };
      pack = { threads = 0; };
      core = { editor = "nvim"; };
      credential = { helper = "store --file ~/.git-credentials"; };
    };
  };
}
