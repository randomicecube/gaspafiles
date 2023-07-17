# modules/system/graphical.nix
#
# Login manager and graphical configuration.

{ pkgs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical;
in
{
  options.modules.graphical = {
    enable = mkEnableOption "graphical";
  };

  config = mkIf cfg.enable {
    hm.services.xscreensaver = {
      enable = true;
      settings = {
        lock = true;
        mode = "random";
        timeout = "5";
        cycle = "1";
      };
    };
  };
}
