# modules/graphic/programs.nix
#
# Useful GUI programs

{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical.programs;
in {
  options.modules.graphical.programs.enable = mkEnableOption "programs";

  config.hm = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord-openasar
      gimp
      insomnia
      obsidian
      thunderbird
      vlc
    ];
  };
}
