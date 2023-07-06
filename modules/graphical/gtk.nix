# modules/graphical/gtk.nix
#
# gtk configuration.

{ pkgs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkForce;
  cfg = config.modules.graphical.gtk;
in
{
  options.modules.graphical.gtk.enable = mkEnableOption "gtk";

  config.hm = mkIf cfg.enable {
    gtk = {
      enable = true;
      font = {
        name = "Fira-Code";
        size = 10;
      };
      theme = {
        package = pkgs.rose-pine-gtk-theme;
        name = "rose-pine";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
    };
  };
}
