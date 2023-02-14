# hosts/system.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/RageKnify/Config
#
# System config common across all hosts

{ inputs, pkgs, lib, config, configDir, ... }:
let
  inherit (builtins) toString;
  inherit (lib.my) mapModules;
in {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nix.settings.trusted-users = [ "root" "@wheel" ];
  security.sudo.extraConfig = ''
    Defaults lecture=never
  '';

  # Every host shares the same time zone.
  #time.timeZone = "Europe/Lisbon";

  location = {
    provider = "manual";
    # Lisboa, Portugal
    latitude = 38.43;
    longitude = -9.8;
  };

  services.journald.extraConfig = ''
    SystemMaxUse=500M
  '';

  users = {
    users.gaspa = {
      isNormalUser = true;
      createHome = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
    };
  };

  environment.shells = [ pkgs.zsh ];

  # Essential packages.
  environment.systemPackages = with pkgs; [
    atool
    cached-nix-shell
    neovim
    tmux
    zip
    unzip
    htop
    neofetch
    man-pages
    fzf
    ripgrep
    procps
    nixfmt
    gdu
    duf
    tree
    # agenixPackage
  ];

  programs.dconf.enable = true;
  services.blueman.enable = config.hardware.bluetooth.enable;

  # dedup equal pages
  hardware.ksm = {
    enable = true;
    sleep = null;
  };

  system.stateVersion = "22.11";
}

