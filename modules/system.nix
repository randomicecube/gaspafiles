# modules/system.nix
#
# System config common across all hosts

{ inputs, pkgs, lib, config, configDir, agenixPackage, ... }:
let
  inherit (builtins) toString;
  inherit (lib.my) mapModules;
in {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    # Lock flake registry to keep it synced with the inputs
    # i.e. used by `nix run nixpkgs#<package>`
    registry = {
      pkgs.flake = inputs.nixpkgs; # alias to nixpkgs
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };
  };
  nix.settings.trusted-users = [ "root" "@wheel" ];
  security.sudo.extraConfig = ''
    Defaults lecture=never
  '';

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
    agenixPackage
    gparted
    wol
  ];

  # Every host shares the same time zone.
  # TODO perhaps set this per host
  time.timeZone = "Europe/Lisbon";

  services.journald.extraConfig = ''
    SystemMaxUse=500M
  '';

  # make zsh a login shell so that lightdm doesn't discriminate
  environment.shells = [ pkgs.zsh ];
  # necessary for completions to work
  programs.zsh.enable = true;

  # dedup equal pages
  hardware.ksm = {
    enable = true;
    sleep = null;
  };
}
