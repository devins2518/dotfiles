{ pkgs, ... }: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host ececomp
        HostName ececomp.ecn.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_rsa
      Host eceprog
        HostName eceprog.ecn.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_rsa
      Host asicfab
        HostName asicfab.ecn.purdue.edu
        User socet21
        IdentityFile ~/.ssh/id_rsa
        ProxyJump ececomp
      Host asicfabu
        HostName asicfabu.ecn.purdue.edu
        User socet21
        IdentityFile ~/.ssh/id_rsa
        ProxyJump ececomp
      Host github.com
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/id_ed25519
    '';
  };
}
