# profiles/graphical/laptop.nix
#
# Laptop-specific graphical configurations.

{ config, lib, profiles, pkgs, ... }:
let
  inherit (lib) mkIf;
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

  services.autorandr = {
    enable = true;
    defaultTarget = "laptop-dual";
    profiles = {
      laptop = {
        fingerprint = { "eDP-1" = "*"; };
        config = {
          eDP-1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            position = "0x0";
            rotate = "normal";
          };
        };
      };
      laptop-dual = {
        fingerprint = {
          "eDP-1" = "*";
          "HDMI-1" = "*";
        };
        config = {
          HDMI-1 = {
            enable = true;
            primary = false;
            mode = "1920x1080";
            position = "0x0";
            rotate = "normal";
          };
          eDP-1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            position = "0x1080";
            rotate = "normal";
          };
        };
      };
    };
    hooks = {
      postswitch = {
        "restart-polybar" = "systemctl --user restart polybar";
      };
    };
  };

  programs.light.enable = true;
  programs.nm-applet.enable = true;
}
