# modules/graphical/dev.nix
#
# Configuration for development (IDEs and other tools).

{ pkgs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical.dev;
in {
  options.modules.graphical.dev.enable = mkEnableOption "dev";

  config.hm = mkIf cfg.enable {
    home.packages = [
      # Visual Studio Code
      pkgs.unstable.vscode
    ];
  };
}

