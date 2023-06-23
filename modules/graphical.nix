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
    # TODO: laptop only
    programs.light.enable = true;
    programs.nm-applet.enable = true;
  };
}
