{ pkgs, config, ... }: {
  home.file.".config/nvfancontrol.conf".text = ''
    25    35
    45    40
    50    50
    60    75
    70    80
    80    90
  '';
}
