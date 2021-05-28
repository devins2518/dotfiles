{
  description = "LegendOfMiracles's system config";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # nixpkgs.url = "/home/devin/Repos/nixpkgs/";
    home-manager.url = "github:nix-community/home-manager";
    agenix.url = "github:ryantm/agenix";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/staging";
  };

  outputs = { self, nixpkgs, home-manager, utils, nixos-hardware, neovim-nightly
    , agenix }@inputs:
    utils.lib.systemFlake {
      inherit self inputs;

      nixosModules = utils.lib.modulesFromList [
        ########### Not done
        # add other scripts here
        ./HM/shell-scripts.nix
        ########### Done for despair
        ./xorg.nix
        ./HM/xorg-hm.nix
        ./HM/qt.nix
        ./HM/dunst.nix
        ./HM/zsh.nix
        #./HM/nvim.nix
        ###########
        ./HM/defaults.nix
        ./HM/git.nix
        ./HM/gtk.nix
        ./HM/mpv.nix
        #./HM/pass.nix
        ./HM/alacritty.nix
        #./HM/firefox.nix
        ./network.nix
        ./defaults-nix.nix
      ];

      hostDefaults = {
        modules = [
          utils.nixosModules.saneFlakeDefaults
          home-manager.nixosModules.home-manager
          #agenix.nixosModules.age
          self.nixosModules.defaults-nix
        ];
        extraArgs = { inherit utils inputs; };
      };

      channels.nixpkgs = {
        input = nixpkgs;
        config = { allowUnfree = true; };
      };

      channels.nixpkgs-unstable = { input = nixpkgs; };

      hosts = {
        #pain = {
        #modules = with self.nixosModules; [
        ## system wide config
        #./hosts/pain/configuration.nix
        #xorg
        #v4l2
        #nixos-hardware.nixosModules.common-cpu-intel
        #network
        #printer
        #({ pkgs, ... }: {
        #home-manager.useUserPackages = true;
        #home-manager.useGlobalPkgs = true;
        #home-manager.users.devin = ({ config, pkgs, ... }:
        #with import ./HM/shell-scripts.nix { inherit pkgs; }; {
        #imports = [
        #firefox
        #git
        #alacritty
        #dunst
        #mpv
        #xorg-hm
        #pass
        #neofetch
        #qt
        #proton
        #zsh
        ##nvim
        #defaults
        #gtk
        #];

        #home.packages = with pkgs; [ screenshot ];
        #});
        #})
        #];
        #};
        despair = {
          modules = with self.nixosModules; [
            # system wide config
            ./hosts/despair/configuration.nix
            network
            xorg
            ({ pkgs, ... }: {
              home-manager.users.devin = ({ config, pkgs, ... }:
                with import ./HM/shell-scripts.nix { inherit pkgs; }; {
                  imports = [
                    #git
                    qt
                    dunst
                    alacritty
                    zsh
                    #nvim
                    gtk
                    xorg-hm
                    defaults
                  ];

                  home.packages = with pkgs;
                    [
                      # custom shell script
                      screenshot
                    ];
                });
              environment.shellAliases = {
                nix-repl = "nix repl ${inputs.utils.lib.repl}";
                nshell = "nix-shell";
                ls = "ls -l --color=always";
              };
              environment.etc."spaceman.png" = {
                source = pkgs.fetchurl {
                  url = "https://w.wallhaven.cc/full/ox/wallhaven-oxkjgm.jpg";
                  sha256 = "sha256-k5lZlGipd1dpOLCBXtOQ58sHxvTH81COTMg/XKuxb6Y=";
                };
              };
            })
          ];
        };
      };

      sharedOverlays = [ neovim-nightly.overlay self.overlay ];

      packagesBuilder = channels: {
        inherit (channels.nixpkgs) alacritty-ligatures neovim-nightly;
      };

      appsBuilder = channels:
        with channels.nixpkgs; {
          alacritty-ligatures = utils.lib.mkApp { drv = alacritty-ligatures; };
        };

      overlay = import ./overlays;
    };
}
