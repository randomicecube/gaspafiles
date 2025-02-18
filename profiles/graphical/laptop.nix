# profiles/graphical/laptop.nix
#
# Laptop-specific graphical configurations.

{ config, lib, profiles, pkgs, ... }:
let
  inherit (lib) mkIf mkForce mkEnableOption;
  cfg = profiles.graphical.laptop;
  customKeebLayout = pkgs.writeText "xkb-layout" ''
    ! bentley doesn't have the tilde/backtick key, switching it to caps lock
    clear lock
    keycode 66 = asciitilde grave asciitilde grave notsign brokenbar notsign
  '';
in {
  services.xserver = {
    #libinput = {
    #  enable = false;
    #  touchpad = {
    #    naturalScrolling = true;
    #    tapping = true;
    #  };
    #};
    displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${customKeebLayout}";
    displayManager.gdm.autoSuspend = false;
  };

  # Touch screen in firefox
  environment.variables.MOZ_USE_XINPUT2 = "1";
  environment.extraInit = ''
    xset s off -dpms
  '';

  programs.light.enable = true;
  programs.nm-applet.enable = true;
}
