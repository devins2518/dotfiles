{
  description = "Devins2518's system config";

  inputs = {
    nixos-hardware.url = "github:devins2518/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # nixpkgs.url = "/home/devin/Repos/nixpkgs/";
    nur.url = "github:nix-community/NUR/master";
    home-manager.url = "github:nix-community/home-manager";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/staging";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
  };

  outputs = { self, nixpkgs, home-manager, utils, nixos-hardware, neovim-nightly
    , agenix, nur, nixpkgs-f2k }@inputs:
    utils.lib.systemFlake rec {
      inherit self inputs;

      nixosModules = utils.lib.modulesFromList [
      ];

      x-org = with self.nixosModules; [
        xorg
        ({ pkgs, ... }: {
          home-manager.users.devin = ({ config, pkgs, ... }:
            {
              imports = [ dunst rofi ];
            });
        })
      ];

      hosts = {
        dev = {
          modules = with self.nixosModules;
            [
              # system wide config
              ./hosts/dev/configuration.nix
              network
              ({ pkgs, ... }: {
                home-manager.useUserPackages = true;
                home-manager.useGlobalPkgs = true;
                home-manager.users.devin = ({ config, pkgs, ... }: {
                  imports = [
                    defaults
                    git
                    gtk
                    mpv
                    cursor
                    nvfancontrol
                    nvim
                    pass
                    pdf
                    qt
                    tmux
                    zathura
                    zsh
                  ] ++ dev.x-org ++ dev.default;
                });
              })
            ] ++ x-org;
        };
        devin = {
          modules = with self.nixosModules;
            [
              # system wide config
              ./hosts/devin/configuration.nix
              nixos-hardware.nixosModules.microsoft-surface
              ({ pkgs, ... }: {
                home-manager.useUserPackages = true;
                home-manager.useGlobalPkgs = true;
                home-manager.users.devin = ({ config, pkgs, ... }: {
                  imports = [
                    mpv
                    pdf
                    qt
                    tmux
                  ] ++ devin.wayland ++ devin.default;
                });
              })
            ];
        };
      };
    };
}
