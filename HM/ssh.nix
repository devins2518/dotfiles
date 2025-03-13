{ pkgs, ... }: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host purdueecejump
        HostName jump.it.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_ed25519_icloud
      Host shayececomp
        Hostname shay.ecn.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_ed25519_icloud
      Host ececomp
        HostName ececomp.ecn.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_ed25519_icloud
        ProxyJump shayececomp
      Host eceprog
        HostName eceprog.ecn.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_ed25519_icloud
        ProxyJump shayececomp
      Host asicfab
        HostName asicfab.ecn.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_ed25519_icloud
        ProxyJump shayececomp
      Host asicfabu
        HostName asicfabu.ecn.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_ed25519_icloud
        ProxyJump ececomp
      Host github.com
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/id_ed25519_icloud
    '';
  };
}
