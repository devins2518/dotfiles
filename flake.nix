{
  description = "Devins2518's system config";

  inputs = {
    darwin = {
      url = "github:ryantking/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    emacs-nightly.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nixpkgs.url = "github:NixOS/nixpkgs";
    # nixpkgs.url = "/home/devin/Repos/nixpkgs/";
    nur.url = "github:nix-community/NUR/master";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    rust-overlay.url = "github:nix-community/fenix";
    nix-ld = {
      url = "github:Mic92/nix-ld";
      # this line assume that you also have nixpkgs as an input
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, fenix, nixpkgs, home-manager, utils, nixos-hardware
    , neovim-nightly, nix-ld, emacs-nightly, nur, nixpkgs-f2k, rust-overlay
    }@inputs:
    utils.lib.mkFlake rec {
      inherit self inputs;

      nixosModules = utils.lib.exportModules [
        ########### Not done
        # add other scripts here
        ./HM/shell-scripts.nix
        ./HM/iterm2.nix
        ./HM/emacs.nix
        ./HM/river.nix
        ./HM/foot.nix
        # ./HM/kakoune.nix
        ########### Done for despair
        ./HM/bspwm.nix
        ./HM/dev
        ./HM/devin
        ./HM/Devins-MacBook-Pro
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
        ./HM/helix.nix
        ./HM/dconf.nix
        ./HM/git.nix
        ./HM/gtk.nix
        ./HM/mpv.nix
        ./HM/nvim.nix
        ./HM/pass.nix
        ./HM/qt.nix
        #./HM/firefox.nix
        ./defaults-nix.nix
        ./defaults-darwin.nix
        ./network.nix
      ];

      hostDefaults = {
        modules = [
          home-manager.nixosModules.home-manager
          self.nixosModules.defaults-nix
          nix-ld.nixosModules.nix-ld
        ];
        extraArgs = { inherit utils inputs; };
      };

      channels = {
        nixpkgs = {
          input = nixpkgs;
          config = { allowUnfree = true; };
        };
        nixpkgs-unstable = { input = nixpkgs; };
        darwin = { input = darwin; };
      };

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

              home.packages = with pkgs; [ compilenote screenshot ];
            });
        })
      ];

      darwinConfigurations."Devins-MacBook-Pro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = with self.nixosModules; [
          # system wide config
          ./hosts/Devins-MacBook-Pro/configuration.nix
          home-manager.darwinModule
          defaults-darwin
          ({ pkgs, ... }: {
            nixpkgs.overlays = sharedOverlays;
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.devin = ({ config, pkgs, ... }:
              with import ./HM/shell-scripts.nix { inherit pkgs; }; {
                imports =
                  [ defaults emacs git iterm2 nvim pass pdf zathura zsh ];

                home.packages = with pkgs; [ cachix-push ];
              });
          })
        ];
      };

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
                home-manager.users.devin = ({ config, pkgs, ... }:
                  with import ./HM/shell-scripts.nix { inherit pkgs; }; {
                    imports = [
                      cursor
                      dconf
                      defaults
                      git
                      gtk
                      helix
                      mpv
                      nvfancontrol
                      nvim
                      pass
                      pdf
                      qt
                      tmux
                      zathura
                      zsh
                    ] ++ dev.x-org ++ dev.default;

                    home.packages = with pkgs; [ cachix-push ];
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
                home-manager.users.devin = ({ config, pkgs, ... }:
                  with import ./HM/shell-scripts.nix { inherit pkgs; }; {
                    imports = [
                      configFolder
                      cursor
                      defaults
                      git
                      gtk
                      helix
                      mpv
                      nvim
                      pass
                      pdf
                      qt
                      tmux
                      zathura
                      zsh
                    ] ++ devin.wayland ++ devin.default;

                    home.packages = with pkgs; [ airplane-mode cachix-push ];
                  });
              })
            ] ++ wayland-opt;
        };
      };

      sharedOverlays = [
        emacs-nightly.overlay
        neovim-nightly.overlay
        nixpkgs-f2k.overlays.default
        nur.overlay
        rust-overlay.overlay
        self.overlay
      ];

      packagesBuilder = channels: {
        inherit (channels.nixpkgs) alacritty-ligatures neovim-nightly helix-git;
      };

      appsBuilder = channels:
        with channels.nixpkgs; {
          alacritty-ligatures = utils.lib.mkApp { drv = alacritty-ligatures; };
          helix-git = utils.lib.mkApp { drv = helix-git; };
        };

      overlay = import ./overlays;
    };
}
