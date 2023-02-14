# modules/home/personal.nix
#
# personal home configuration.

{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.personal;
in {
  options.modules.personal.enable = mkEnableOption "personal";

  config = mkIf cfg.enable {
    home.packages = with pkgs;[
      # agenix
      # agenix
      # calc
      libqalculate
      # LaTeX
      texlive.combined.scheme-full
      texlab
      # Rust
      rustup
      pkgs.unstable.rust-analyzer
      # GCC
      gcc
      # Make
      gnumake
      # killall
      killall
    ];
  };
}

