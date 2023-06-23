# profiles/graphical/laptop.nix
#
# Laptop-specific graphical configurations.

{ config, lib, profiles, ... }:
let
  inherit (lib) mkIf;
  cfg = profiles.graphical.laptop;
in {
  services.xserver = {
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = true;
      };
    };
  };

  programs.light.enable = true;
  programs.nm-applet.enable = true;
}
