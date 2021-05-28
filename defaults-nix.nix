{ pkgs, config, lib, inputs, ... }:

{
  #age.secrets.variables = {
  #file = ./secrets/variables.age;
  #owner = "nix";
  #mode = "0700";
  #};
  #age.secrets.wpa = {
  #file = ./secrets/wpa_supplicant.conf.age;
  #mode = "0700";
  #};
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  environment.sessionVariables = {
    NIXOS_CONFIG = "/home/devin/Repos/dotfiles";
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.devin = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Devin Singh";
      extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    };
  };

  security.sudo.wheelNeedsPassword = false; # wheel ALL=(ALL) NOPASSWD:ALL

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "root" "devin" ];

    maxJobs = 4;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    nixPath = [ "nixpkgs=${pkgs.path}" "home-manager=${inputs.home-manager}" ];
  };

  programs = {
    command-not-found.enable = false;
    zsh = {
      enable = true;
      histSize = 2000;
      histFile = "$HOME/.zsh/HISTFILE";
    };
  };

  nixpkgs.config = { allowUnfree = true; };
  environment.systemPackages = with pkgs; [
    #alacritty use alacritty-ligatures
    firefox
    rustup
    discord
    nixfmt
    home-manager
    lm_sensors
    rofi
    pcmanfm
    xdotool
    polybar
    alttab
    feh
    gcc
    picom
    #gnomeExtensions.dash-to-dock
    dunst
    bottom
    go
    tokei
  ];

  # Needed for home manager to not get borked
  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "JetBrainsMono" ]; })
      font-awesome
    ];
  };
}
