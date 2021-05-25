{ config, pkgs, ... }: {
  config = {
    programs.git = {
      enable = true;

      userName = "Devin Singh";
      userEmail = "drsingh2518@icloud.com";

      aliases = { cush = "!git commit && git push"; };

      extraConfig = {
        init.defaultBranch = "master";
        core.editor = "nvim";
        credential.helper = "store --file ~/.git-credentials";
        pull.rebase = "false";
        commit.gpgSign = "true";
      };

    };
  };
}
