{ pkgs, ... }: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host ececomp
        HostName ececomp.ecn.purdue.edu
        User singh956
        PasswordAuthentication yes
      Host eceprog
        HostName eceprog.ecn.purdue.edu
        User singh956
        PasswordAuthentication yes
      Host asicfab
        HostName asicfab.ecn.purdue.edu
        User socet21
        PasswordAuthentication yes
      Host asicfabu
        HostName asicfabu.ecn.purdue.edu
        User socet21
        PasswordAuthentication yes
      Host github.com
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/id_ed25519
    '';
  };
}
