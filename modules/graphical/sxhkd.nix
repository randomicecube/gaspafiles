# modules/graphical/sxhkd.nix
#
# sxhkd configuration.

{ pkgs, config, lib, colors, configDir, agenixPackage, secretsDir, ... }:
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
        "${sxhkdMod}+b"         = "rofi-bluetooth";
        # TODO: whenever available, add rofi-wifi-menu

        "Print"                 = "flameshot gui";
        "${sxhkdMod}+Delete"    = "flameshot gui"; # mech keeb doesn't have print key
        "${sxhkdMod}+x"         = "${configDir}/utils/scripts/lock.sh";

        # WoL scripts
        "${sxhkdMod}+z"   = "${configDir}/utils/scripts/wol.sh ${config.age.secrets.slyMachineAddress.file} sly.gaspa.pt ${secretsDir}"; # wol sly

        # reloads polybar, useful for when tray bugs out
        "${sxhkdMod}+y"         = "${configDir}/utils/scripts/reload-polybar.sh";

        # pauses dunst notification-display
        "${sxhkdMod}+j"         = "${pkgs.dunst}/bin/dunstctl set-paused toggle";

        "XF86AudioMute"         = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioRaiseVolume"  = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume"  = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMicMute"      = "pactl set-source-mute 0 toggle";

        # FIXME: these assume programs.light.enable in system
        "XF86MonBrightnessUp"   = "light -A 10";
        "XF86MonBrightnessDown" = "light -U 10";
      };
    };

    # for access to pactl
    home.packages = [
      pkgs.pulseaudio
    ];
  };
}
