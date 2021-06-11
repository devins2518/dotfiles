{
  description = "Devins2518's system config";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # nixpkgs.url = "/home/devin/Repos/nixpkgs/";
    home-manager.url = "github:nix-community/home-manager";
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
        ./HM/tmux.nix
        ./HM/xorg-hm.nix
        ./HM/rofi.nix
        ./HM/zathura.nix
        ./HM/dunst.nix
        ./HM/polybar.nix
        ########### Done fully i think
        ./HM/zsh/zsh-despair.nix
        ./HM/zsh/zsh-pain.nix
        ./HM/zsh/zsh.nix
        ./HM/nvfancontrol.nix
        ###########
        ./HM/nvim.nix
        ./HM/qt.nix
        ./HM/defaults.nix
        ./HM/git.nix
        ./HM/gtk.nix
        ./HM/mpv.nix
        ./HM/pass.nix
        ./HM/alacritty.nix
        #./HM/firefox.nix
        ./network.nix
        ./defaults-nix.nix
      ];

      hostDefaults = {
        modules = [
          utils.nixosModules.saneFlakeDefaults
          home-manager.nixosModules.home-manager
          agenix.nixosModules.age
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
        pain = {
          modules = with self.nixosModules; [
            # system wide config
            ./hosts/pain/configuration.nix
            network
            xorg
            ({ pkgs, ... }: {
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.devin = ({ config, pkgs, ... }:
                with import ./HM/shell-scripts.nix { inherit pkgs; }; {
                  imports = [
                    git
                    alacritty
                    dunst
                    mpv
                    xorg-hm
                    pass
                    qt
                    zsh
                    zsh-pain
                    nvim
                    defaults
                    gtk
                    nvfancontrol
                    zathura
                    tmux
                    polybar
                    rofi
                  ];

                  home.packages = with pkgs; [ 
                    screenshot
                    autoclose
                  ];
                });
            })
          ];
        };
        despair = {
          modules = with self.nixosModules; [
            # system wide config
            ./hosts/despair/configuration.nix
            network
            xorg
            nixos-hardware.nixosModules.microsoft-surface
            ({ pkgs, ... }: {
              home-manager.users.devin = ({ config, pkgs, ... }:
                with import ./HM/shell-scripts.nix { inherit pkgs; }; {
                  imports = [
                    git
                    alacritty
                    dunst
                    mpv
                    xorg-hm
                    pass
                    qt
                    zsh
                    zsh-despair
                    nvim
                    defaults
                    gtk
                    zathura
                    tmux
                    polybar
                    rofi
                  ];

                  home.packages = with pkgs;
                    [
                      # custom shell script
                      screenshot
                      autoclose
                    ];
                });
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
