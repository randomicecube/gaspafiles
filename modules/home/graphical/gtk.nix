# modules/home/graphical/gtk.nix
#
# gtk configuration.

{ pkgs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkForce;
  cfg = config.modules.graphical.gtk;
in
{
  options.modules.graphical.gtk.enable = mkEnableOption "gtk";

  config = mkIf cfg.enable {
    gtk.enable = true;
    gtk = {
      font = {
        name = "Fira-Code";
        size = 10;
      };
      theme = {
        package = pkgs.rose-pine-gtk-theme;
        name = "Rose-Pine";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
    };
  };
}
