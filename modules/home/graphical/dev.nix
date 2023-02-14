# modules/home/graphical/dev.nix
#
# Configuration for development (IDEs and other tools).

{ pkgs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical.dev;
in {
  options.modules.graphical.dev.enable = mkEnableOption "dev";

  config = mkIf cfg.enable {
    home.packages = [
      # Jetbrains Gateway (remote development)
      pkgs.unstable.jetbrains.gateway
      # IntelliJ IDEA (Ultimate)
      pkgs.unstable.jetbrains.idea-ultimate
      # Visual Studio Code
      pkgs.unstable.vscode
    ];
  };
}

