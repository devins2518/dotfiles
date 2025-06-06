{ pkgs, config, lib, inputs, ... }:

let
  inherit (lib)
    mkIf filterAttrs mapAttrs mapAttrsToList mapAttrs' mkOption types;
  filteredInputs = filterAttrs (n: _: n != "self") inputs;
  nixPathInputs = mapAttrsToList (n: v: "${n}=${v}") filteredInputs;
  registryInputs = mapAttrs (_: v: { flake = v; }) filteredInputs;

  nur-packages = with pkgs.nur.repos;
    [
      devins2518.bunnyfetch-rs
      # devins2518.gyro
    ];
  tex = (pkgs.texlive.combine { inherit (pkgs.texlive) scheme-full syntax; });

in rec {
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  environment = {
    variables = { NIXOS_CONFIG = "/Users/devin/Repos/dotfiles"; };
  };

  users = {
    users = {
      devin = {
        name = "devin";
        shell = pkgs.zsh;
        description = "Devin Singh";
        home = "/Users/devin";
      };
    };
  };

  ids.uids.nixbld = 300;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    registry = registryInputs;

    gc = {
      automatic = false;
      options = "--delete-older-than 7d";
    };

    nixPath = {
      nixpkgs = "${pkgs.path}";
      darwin-config =
        "$HOME/Repos/dotfiles/hosts/Devins-MacBook-Pro/configuration.nix";
      # home-manager = "${inputs.home-manager}";
      darwin = "${inputs.darwin}";
    };

    settings = {
      trusted-users = [ "root" "devin" ];

      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://fortuneteller2k.cachix.org"
        "https://devins2518.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
        "devins2518.cachix.org-1:VQepMECpWpT95AjVOU30xz6kbrBRUMpHAOdKP/tulB0="
      ];
    };
  };

  nixpkgs.config = { allowUnfree = true; };

  environment.systemPackages = with pkgs;
    [
      bottom
      cachix
      cargo-flamegraph
      clang-tools
      coq
      coqPackages.coq-lsp
      direnv
      discord
      dune_3
      ffmpeg
      gimp
      gnumake
      hyperfine
      iterm2
      jq
      luaformatter
      meson
      nil
      ninja
      nixfmt
      nixpkgs-review
      ocamlformat
      python311Packages.python-lsp-server
      ripgrep
      rust-analyzer
      stylish-haskell
      sumneko-lua-language-server
      svlint
      inputs.neovim-nightly.packages.${pkgs.system}.default
      svls
      texlab
      tex
      tokei
      tree
      unzip
      # verible
      vscode-extensions.vadimcn.vscode-lldb
      wget
      xxd
      inputs.zls-master.packages.${pkgs.system}.default
      inputs.zig-overlay.packages.${pkgs.system}.master
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

  system.activationScripts.applications.text = lib.mkForce ''
    echo "setting up ~/Applications..." >&2
    applications="/Users/devin/Applications"
    nix_apps="$applications/Nix Apps"

    # Needs to be writable by the user so that home-manager can symlink into it
    if ! test -d "$applications"; then
        mkdir -p "$applications"
        chown devin "$applications"
        chmod u+w "$applications"
    fi

    # Delete the directory to remove old links
    rm -rf "$nix_apps"
    mkdir -p "$nix_apps"
    find ${config.system.build.applications}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
            # Spotlight does not recognize symlinks, it will ignore directory we link to the applications folder.
            # It does understand MacOS aliases though, a unique filesystem feature. Sadly they cannot be created
            # from bash (as far as I know), so we use the oh-so-great Apple Script instead.
            osascript -e "
                set fileToAlias to POSIX file \"$src\"
                set applicationsFolder to POSIX file \"$nix_apps\"
                tell application \"Finder\"
                    make alias file to fileToAlias at applicationsFolder
                    # This renames the alias; 'mpv.app alias' -> 'mpv.app'
                    set name of result to \"$(rev <<< "$src" | cut -d'/' -f1 | rev)\"
                end tell
            " 1>/dev/null
        done
  '';

  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      font-awesome
      material-design-icons
      nur.repos.devins2518.iosevka-serif
      tenderness
      spleen
    ];
  };
}
