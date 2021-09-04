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
    nix-ld = {
      url = "github:Mic92/nix-ld";
      # this line assume that you also have nixpkgs as an input
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, utils, nixos-hardware, neovim-nightly
    , nix-ld, nur, nixpkgs-f2k }@inputs:
    utils.lib.systemFlake rec {
      inherit self inputs;

      nixosModules = utils.lib.modulesFromList [
        ########### Not done
        # add other scripts here
        ./HM/shell-scripts.nix
        ./HM/river.nix
        ./HM/foot.nix
        # ./HM/kakoune.nix
        ########### Done for despair
        ./HM/bspwm.nix
        ./HM/dev
        ./HM/devin
        ./HM/dunst.nix
        ./HM/pdf.nix
        ./HM/rofi.nix
        ./HM/tmux.nix
        ./HM/xorg-hm.nix
        ./HM/mako.nix
        ./HM/zathura.nix
        ./HM/cursor.nix
        ./HM/configFolder.nix
        ./xorg.nix
        ./wayland.nix
        ########### Done fully i think
        ./HM/nvfancontrol.nix
        ./HM/zsh.nix
        ###########
        ./HM/alacritty.nix
        ./HM/defaults.nix
        ./HM/dconf.nix
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
          home-manager.nixosModules.home-manager
          self.nixosModules.defaults-nix
          nix-ld.nixosModules.nix-ld
          utils.nixosModules.saneFlakeDefaults
        ];
        extraArgs = { inherit utils inputs; };
      };

      channels.nixpkgs = {
        input = nixpkgs;
        config = { allowUnfree = true; };
      };

      channels.nixpkgs-unstable = { input = nixpkgs; };

      x-org = with self.nixosModules; [
        xorg
        ({ pkgs, ... }: {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          home-manager.users.devin = ({ config, pkgs, ... }:
            with import ./HM/shell-scripts.nix {
              inherit pkgs;
              clipboard = "xclip -selection clipboard";
              sstool = "maim";
              selarg = "-s";
            }; {
              imports = [ alacritty bspwm dunst rofi xorg-hm ];

              home.packages = with pkgs; [ autoclose compilenote screenshot ];
            });
        })
      ];

      wayland-opt = with self.nixosModules; [
        wayland
        ({ pkgs, ... }: {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          home-manager.users.devin = ({ config, pkgs, ... }:
            with import ./HM/shell-scripts.nix {
              inherit pkgs;
              clipboard = "wl-copy";
              sstool = "grim -c";
              selarg = ''-g "$(slurp)"'';
            }; {
              imports = [ foot river dconf mako ];

              home.packages = with pkgs; [ autoclose compilenote screenshot ];
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
              network
              nixos-hardware.nixosModules.microsoft-surface
              ({ pkgs, ... }: {
                home-manager.useUserPackages = true;
                home-manager.useGlobalPkgs = true;
                home-manager.users.devin = ({ config, pkgs, ... }: {
                  imports = [
                    configFolder
                    defaults
                    git
                    cursor
                    gtk
                    mpv
                    nvim
                    pass
                    #pdf
                    qt
                    tmux
                    zathura
                    zsh
                  ] ++ devin.wayland ++ devin.default;
                });
              })
            ] ++ wayland-opt;
        };
      };

      sharedOverlays =
        [ self.overlay neovim-nightly.overlay nur.overlay nixpkgs-f2k.overlay ];

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
