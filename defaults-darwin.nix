{ pkgs, config, lib, inputs, ... }:

let
  inherit (lib)
    mkIf filterAttrs mapAttrs mapAttrsToList mapAttrs' mkOption types;
  filteredInputs = filterAttrs (n: _: n != "self") inputs;
  nixPathInputs = mapAttrsToList (n: v: "${n}=${v}") filteredInputs;
  registryInputs = mapAttrs (_: v: { flake = v; }) filteredInputs;

  nur-packages = with pkgs.nur.repos; [
    devins2518.bunnyfetch-rs
    devins2518.gyro
    devins2518.zig-master
    devins2518.zls
  ];
in rec {
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  environment = {
    variables = { NIXOS_CONFIG = "/Users/devin/Repos/dotfiles"; };
  };

  users = {
    users = {
      devin = {
        shell = pkgs.zsh;
        description = "Devin Singh";
        home = "/Users/devin";
      };
    };
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "root" "devin" ];

    registry = registryInputs;

    gc = {
      automatic = true;
      user = "root";
      options = "--delete-older-than 7d";
    };

    nixPath = {
      nixpkgs = "${pkgs.path}";
      darwin-config =
        "$HOME/Repos/dotfiles/hosts/Devins-MacBook-Pro/configuration.nix";
      # home-manager = "${inputs.home-manager}";
      darwin = "${inputs.darwin}";
    };

    binaryCaches = [
      "https://cache.nixos.org?priority=10"
      "https://nix-community.cachix.org"
      "https://fortuneteller2k.cachix.org"
      "https://devins2518.cachix.org"
    ];

    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
      "devins2518.cachix.org-1:VQepMECpWpT95AjVOU30xz6kbrBRUMpHAOdKP/tulB0="
    ];
  };

  nixpkgs.config = { allowUnfree = true; };

  environment.systemPackages = with pkgs;
    [
      bottom
      cachix
      cargo-tarpaulin
      clang
      clang-tools
      discord-ptb
      ffmpeg
      gnumake
      helix-git
      hyperfine
      iterm2
      jq
      lldb
      llvm
      luaformatter
      meson
      ninja
      nixfmt
      nixpkgs-review
      ocamlformat
      ripgrep
      rnix-lsp
      rust-analyzer-nightly
      stylish-haskell
      sumneko-lua-language-server
      tokei
      tree
      unzip
      wget
      xxd
      zsh
    ] ++ nur-packages ++

    [
      (fenix.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      # (emacsWithPackagesFromUsePackage {
      #   config = ./HM/emacs/init.el;
      #   package = pkgs.emacsGcc;
      #   alwaysEnsure = true;
      #   extraEmacsPackages = epkgs:
      #     with epkgs; [
      #       # Dylib broken on M1
      #       tree-sitter
      #       # tree-sitter-langs
      #       all-the-icons
      #       dashboard
      #       doom-themes
      #       evil
      #       evil-collection
      #       evil-numbers
      #       evil-surround
      #       evil-surround
      #       general
      #       highlight-indent-guides
      #       key-chord
      #       lsp-mode
      #       projectile
      #       rainbow-delimiters
      #       smartparens
      #       treemacs
      #       flycheck
      #       company
      #       flycheck-inline
      #       lsp-mode
      #       lsp-ui
      #       treemacs-evil
      #       use-package
      #       which-key
      #       esup
      #     ];
      # })
    ];

  programs = {
    gnupg.agent.enable = true;
    zsh = {
      enable = true;
      enableCompletion = false;
    };
  };

  system.activationScripts.applications.text = pkgs.lib.mkForce (''
      echo "setting up /Applications/Nix..."
      mkdir -p /Applications/Nix
      chown devin /Applications/Nix
      find ${config.system.build.applications}/Applications -maxdepth 1 -type l | while read f; do
        src=$(/usr/bin/stat -f%Y "$f")
        appname=$(basename $src)
        sudo cp -rf "$src" /Applications/Nix
    done
  '');

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
      font-awesome
      material-design-icons
      nur.repos.devins2518.iosevka-serif
      tenderness
      spleen
    ];
  };
}
