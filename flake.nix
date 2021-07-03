{
  description = "Devins2518's system config";

  inputs = {
    nixos-hardware.url =
      "github:NixOS/nixos-hardware/7305b276c90cfd3ad0a2452101a49c0b52c784c0";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # nixpkgs.url = "/home/devin/Repos/nixpkgs/";
    nur.url = "github:nix-community/NUR/master";
    home-manager.url = "github:nix-community/home-manager";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/staging";
  };

  outputs = { self, nixpkgs, home-manager, utils, nixos-hardware, neovim-nightly
    , agenix, nur }@inputs:
    utils.lib.systemFlake {
      inherit self inputs;

      nixosModules = utils.lib.modulesFromList [
        ########### Not done
        # add other scripts here
        ./HM/shell-scripts.nix
        ./HM/kakoune.nix
        ########### Done for despair
        ./HM/bspwm.nix
        ./HM/dev
        ./HM/devin
        ./HM/dunst.nix
        ./HM/pdf.nix
        ./HM/polybar.nix
        ./HM/rofi.nix
        ./HM/tmux.nix
        ./HM/xorg-hm.nix
        ./HM/zathura.nix
        ./HM/zoxide.nix
        ./xorg.nix
        ########### Done fully i think
        ./HM/nvfancontrol.nix
        ./HM/zsh.nix
        ###########
        ./HM/alacritty.nix
        ./HM/defaults.nix
        ./HM/git.nix
        ./HM/gtk.nix
        ./HM/mpv.nix
        ./HM/nvim.nix
        ./HM/pass.nix
        ./HM/qt.nix
        #./HM/firefox.nix
        ./defaults-nix.nix
        ./network.nix
      ];

      hostDefaults = {
        modules = [
          agenix.nixosModules.age
          home-manager.nixosModules.home-manager
          self.nixosModules.defaults-nix
          utils.nixosModules.saneFlakeDefaults
        ];
        extraArgs = { inherit utils inputs; };
      };

      channels.nixpkgs = {
        input = nixpkgs;
        config = { allowUnfree = true; };
      };

      channels.nixpkgs-unstable = { input = nixpkgs; };

      hosts = {
        dev = {
          modules = with self.nixosModules; [
            # system wide config
            ./hosts/dev/configuration.nix
            network
            xorg
            ({ pkgs, ... }: {
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.devin = ({ config, pkgs, ... }:
                with import ./HM/shell-scripts.nix { inherit pkgs; }; {
                  imports = [
                    alacritty
                    bspwm
                    defaults
                    dev
                    dunst
                    git
                    gtk
                    mpv
                    nvfancontrol
                    nvim
                    pass
                    pdf
                    polybar
                    qt
                    rofi
                    tmux
                    xorg-hm
                    zathura
                    zoxide
                    zsh
                  ];

                  home.packages = with pkgs; [
                    autoclose
                    compilenote
                    screenshot
                  ];
                });
            })
          ];
        };
        devin = {
          modules = with self.nixosModules; [
            # system wide config
            ./hosts/devin/configuration.nix
            network
            nixos-hardware.nixosModules.microsoft-surface
            xorg
            ({ pkgs, ... }: {
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.devin = ({ config, pkgs, ... }:
                with import ./HM/shell-scripts.nix { inherit pkgs; }; {
                  imports = [
                    alacritty
                    bspwm
                    defaults
                    devin
                    dunst
                    git
                    gtk
                    mpv
                    nvim
                    pass
                    pdf
                    polybar
                    qt
                    rofi
                    tmux
                    xorg-hm
                    zathura
                    zoxide
                    zsh
                  ];

                  home.packages = with pkgs; [
                    autoclose
                    compilenote
                    screenshot
                  ];
                });
            })
          ];
        };
      };

      sharedOverlays = [ self.overlay neovim-nightly.overlay nur.overlay ];

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
