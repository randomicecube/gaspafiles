# profiles/graphical/laptop.nix
#
# Laptop-specific graphical configurations.

{ config, lib, profiles, pkgs, ... }:
let
  inherit (lib) mkIf mkForce mkEnableOption;
  cfg = profiles.graphical.laptop;
  customKeebLayout = pkgs.writeText "xkb-layout" ''
    ! bentley's backslash key is broken, switching it to caps lock
    clear lock
    keycode 66 = backslash bar backslash bar notsign brokenbar notsign
  '';
in {
  services.xserver = {
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = true;
      };
    };
    displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${customKeebLayout}";
  };

  # Touch screen in firefox
  environment.variables.MOZ_USE_XINPUT2 = "1";

  programs.light.enable = true;
  programs.nm-applet.enable = true;
}
