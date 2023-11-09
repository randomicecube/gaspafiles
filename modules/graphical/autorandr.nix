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
      defaultTarget = "laptop-home";
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
        laptop-home = {
          fingerprint = {
            "eDP-1" = "*";
            "HDMI-1" = "*";
          };
          config = {
            HDMI-1 = {
              enable = true;
              primary = true;
              mode = "3440x1440";
              position = "0x0";
              rotate = "normal";
            };
            eDP-1 = {
              enable = true;
              primary = false;
              mode = "1920x1080";
              position = "180x1440";
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
