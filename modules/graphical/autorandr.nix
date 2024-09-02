# modules/graphical/autorandr.nix
#
# autorandr configuration

{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkForce mkEnableOption;
  cfg = config.modules.graphical.autorandr;
in {
  options.modules.graphical.autorandr.enable = mkEnableOption "autorandr";

  config = mkIf cfg.enable {
    services.autorandr = {
      enable = true;
      defaultTarget = "laptop-sthlm";
      profiles = {
        laptop = {
          fingerprint = { "eDP-1" = "*"; };
          config = {
            eDP-1 = {
              enable = true;
              primary = true;
              mode = "1920x1200";
              position = "0x0";
              rotate = "normal";
            };
          };
        };
        laptop-sthlm = {
          fingerprint = {
            "eDP-1" = "*";
            "DP-2" = "*";
          };
          config = {
            DP-2 = {
              enable = true;
              primary = true;
              mode = "3440x1440";
              position = "0x0";
              rotate = "normal";
            };
            eDP-1 = {
              enable = true;
              primary = false;
              mode = "1920x1200";
              position = "760x1440";
              rotate = "normal";
            };
          };
        };
        laptop-lx = {
          fingerprint = {
            "eDP-1" = "*";
            "HDMI-1" = "*";
          };
          config = {
            HDMI-1 = {
              enable = true;
              primary = true;
              mode = "1920x1080";
              position = "0x0";
              rotate = "normal";
            };
            eDP-1 = {
              enable = true;
              primary = false;
              mode = "1920x1200";
              position = "0x1080";
              rotate = "normal";
            };
          };
        };
        laptop-ist = {
          fingerprint = {
            "eDP-1" = "*";
            "DP-1" = "*";
          };
          config = {
            DP-1 = {
              enable = true;
              primary = true;
              mode = "3840x2160";
              position = "0x0";
              rotate = "normal";
            };
            eDP-1 = {
              enable = true;
              primary = false;
              mode = "1920x1200";
              position = "540x2160";
              rotate = "normal";
            };
          };
        };
      };
      hooks = {
        postswitch = {
          "touch" = ''
            xinput list --name-only | grep 'Wacom' | while read -r line; do
              xinput map-to-output "$line" eDP-1
            done
          '';
          "restart-polybar" = "systemctl --user restart polybar";
        };
      };
    };
  };
}
