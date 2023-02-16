# modules/home/xdg.nix
#
# XDG home configuration

{ pkgs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.xdg;
in {
  options.modules.xdg.enable = mkEnableOption "xdg";

  config.hm = mkIf cfg.enable {
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        desktop = "${config.my.homeDirectory}/Desktop";
        documents = "${config.my.homeDirectory}/Documents";
        download = "${config.my.homeDirectory}/Downloads";
        music = "${config.my.homeDirectory}/Music";
        pictures = "${config.my.homeDirectory}/Pictures";
        publicShare = "${config.my.homeDirectory}/.public";
        templates = "${config.my.homeDirectory}/.templates";
        videos = "${config.my.homeDirectory}/Videos";
      };
      configFile."mimeapps.list".force = true;
    };
  };
}

