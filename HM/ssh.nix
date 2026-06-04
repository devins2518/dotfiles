{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host deepspeed2
        HostName deepspeed2.ecn.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_ed25519_icloud
      Host ececomp
        HostName ececomp.ecn.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_ed25519_icloud
        LocalCommand ~/.local/bin/zsh
      Host asicfab
        HostName asicfab.ecn.purdue.edu
        User singh956
        ProxyJump ececomp
        IdentityFile ~/.ssh/id_ed25519_icloud
      Host qstruct
        HostName qstruct.ecn.purdue.edu
        User singh956
      Host gpu
        HostName gpu.scholar.rcac.purdue.edu
        User singh956
        IdentityFile ~/.ssh/id_ed25519_icloud
      Host asicfabu
        HostName asicfabu.ecn.purdue.edu
        User singh956
      Host github.com
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/id_ed25519_icloud
    '';
  };
}
