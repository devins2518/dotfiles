{ pkgs, config, lib, inputs, ... }:
let nur-packages = with pkgs.nur.repos.devins2518; [ midle ];
in {
  environment = {
    sessionVariables = {
    };

    systemPackages = with pkgs;
      [
      ] ++ nur-packages;
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd river";
      };
    };
  };
}
