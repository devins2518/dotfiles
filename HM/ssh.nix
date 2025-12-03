{ pkgs, ... }: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host purduejump
        HostName jump.it.purdue.edu
        User singh956
      Host deepspeed2
        HostName deepspeed2.ecn.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_ed25519_icloud
      Host ececomp
        HostName ececomp.ecn.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_ed25519_icloud
        ProxyJump purduejump
      Host asicfab
        HostName asicfab.ecn.purdue.edu
        User singh956
        ProxyJump ececomp
      Host qstruct
        HostName qstruct.ecn.purdue.edu
        User singh956
        ProxyJump purduejump
      Host asicfabu
        HostName asicfabu.ecn.purdue.edu
        User singh956
        ProxyJump ececomp
      Host github.com
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/id_ed25519_icloud
    '';
  };
}
