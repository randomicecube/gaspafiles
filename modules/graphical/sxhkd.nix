# modules/graphical/sxhkd.nix
#
# sxhkd configuration.

{ pkgs, config, lib, colors, configDir, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical.sxhkd;
  sxhkdMod = "mod4";
in
{
  options.modules.graphical.sxhkd.enable = mkEnableOption "sxhkd";

  config.hm = mkIf cfg.enable {
    xsession.windowManager.i3.config.startup = [
        { command = "sxhkd"; notification = false; }
    ];
    services.sxhkd = {
      enable = true;
      keybindings = {
        "${sxhkdMod}+p"         = "rofi -show drun";
        "${sxhkdMod}+c"         = "rofi -show calc -modi calc -no-show-match -no-sort";
        "${sxhkdMod}+i"         = "rofi -show power-menu -modi power-menu:rofi-power-menu";
        "${sxhkdMod}+h"         = "rofi -modi 'clipboard:greenclip print' -show clipboard";
        "${sxhkdMod}+Shift+b"   = "rofi-bluetooth";
        # TODO: whenever available, add rofi-wifi-menu

        "${sxhkdMod}+Print"     = "flameshot gui";
        "${sxhkdMod}+Delete"    = "flameshot gui";

        "${sxhkdMod}+x"         = "${configDir}/utils/scripts/lock.sh";

        # reloads polybar, useful for when tray bugs out
        "${sxhkdMod}+y"         = "${configDir}/utils/scripts/reload-polybar.sh";

        "XF86AudioMute"         = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioRaiseVolume"  = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume"  = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMicMute"      = "pactl set-source-mute 0 toggle";

        # FIXME: these assume programs.light.enable in system
        "XF86MonBrightnessUp"   = "light -A 10";
        "XF86MonBrightnessDown" = "light -U 10";
      };
    };

    services.flameshot = {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;
        };
      };
    };

    # for access to pactl
    home.packages = [
      pkgs.pulseaudio
    ];
  };
}
