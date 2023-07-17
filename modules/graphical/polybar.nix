# modules/graphical/polybar.nix
#
# polybar configuration.


{ pkgs, config, lib, hostName, colors, configDir, ... }:
let
  inherit (lib) mkEnableOption mkIf mkForce;
  cfg = config.modules.graphical.polybar;
in
{
  options.modules.graphical.polybar.enable = mkEnableOption "polybar";

  config.hm = mkIf cfg.enable {
    systemd.user.services.polybar = {
      Unit.PartOf = mkForce [ "graphical-session-i3.target" ];
      Install.WantedBy = mkForce [ "graphical-session-i3.target" ];
    };
    services.polybar = {
      enable = true;
      settings = {
        colors = {
          bg      = "#181825";
          fg      = "#45475a";
          trayBg  = "#232338";
          white   = "#cdd6f4";
          black   = "#1e1e2e";
          blue    = "#89b4fa";
          red     = "#f38ba8";
          green   = "#a6e3a1";
          yellow  = "#f9e2af";
          cyan    = "#89dceb";
          magenta = "#eba0ac";
          purple  = "#c8a2c8";
        };
        "global/wm" = {
          margin-top    = 1;
          margin-bottom = 1;
        };
        "bar/bar" = {
          width = "100%";
          height = 35;
          radius = 0;
          fixed-center = true;
          monitor-strict = true;
          monitor = "\${env:MONITOR:}";
          background = "\${colors.bg}";
          foreground = "\${colors.fg}";
          border-size  = 1;
          border-color = "\${colors.black}";
          padding       = 2;
          module-margin = 1;
          font-0 = "JetbrainsMono Nerd Font:size=10;2";
          font-1 = "FontAwesome:size=10;2";
          font-2 = "MaterialIcons:size=10;2";
          modules-left    = "i3";
          modules-center  = "time";
          modules-right   = "timewarrior dunst-pause pulseaudio memory cpu temperature battery";
          wm-restack = "i3";
          cursor-click = "pointer";

          tray-position = "right";
          tray-padding = 2;
          tray-background = "\${colors.trayBg}";
        };
        "module/i3" = {
          type = "internal/i3";
          pin-workspaces = true;
          enable-click = true;
          enable-scroll = true;
          format-padding = 1;
          show-all = true;
          ws-num = 8;
          ws-icon-0 = "1;1";
          ws-icon-1 = "2;2";
          ws-icon-2 = "3;3";
          ws-icon-3 = "4;4";
          ws-icon-4 = "5;5";
          ws-icon-5 = "6;6";
          ws-icon-6 = "7;7";
          ws-icon-7 = "8;8";
          ws-icon-8 = "9;9";
          ws-icon-9 = "10;10";

          ws-icon-default ="";

          format = "<label-state>";
          format-background = "\${colors.bg}";

          label-focused = "%icon%";
          label-focused-padding = 1;
          label-focused-foreground = "\${colors.yellow}";

          label-unfocused = "%icon%";
          label-unfocused-padding = 1;
          label-unfocused-foreground = "\${colors.fg}";

          label-visible = "%icon%";
          label-visible-padding = 1;
          label-visible-foreground = "\${colors.yellow}";

          label-urgent = "%icon%";
          label-urgent-padding = 1;
          label-urgent-foreground = "\${colors.yellow}";
        };
        "module/time" = {
          type = "internal/date";
          interval = 1;
          label-foreground = "\${colors.white}";
          date = "%Y-%m-%d%";
          time = "%H:%M";
          label = "%date% | %time%";
        };
        "module/dunst-pause" = {
          type = "custom/script";
          label = "%output%";
          tail = true;
          interval = 1;
          exec = pkgs.writeShellScript "sb-dunst-pause" ''
            #!/usr/bin/env bash

            # Module showing if dunst is paused and if so, how many notifications are pending
            # Icon is ommited if not paused

            DUNST=${pkgs.dunst}/bin/dunstctl
            PATH=$PATH:${pkgs.dbus}/bin

            OUT=""

            if [ "$($DUNST is-paused)" = "true" ]; then
              OUT="󰂛"
              WAITING="$($DUNST count waiting)"
              if [ $WAITING != 0 ]; then
                OUT="$OUT ($WAITING)"
              fi
            fi

            echo $OUT
          '';
          exec-if = true;
          format = "<label> ";
          format-foreground = "\${colors.yellow}";
        };
        "module/timewarrior" = {
          type = "custom/script";
          label = "%output%";
          tail = true;
          interval = 1;
          exec = pkgs.writeShellScript "sb-timew" ''
            #!/usr/bin/env bash

            # Prints whether or not there is current timetracking with timewarrior.
            # Used in the polybar config

            current_tracking="$(${pkgs.timewarrior}/bin/timew | ${pkgs.coreutils}/bin/head -n 1)"
            if [ "$current_tracking" = "There is no active time tracking." ]; then
              icon="󰚭 n/a"
            else
              icon="󱦟 $(echo $current_tracking | ${pkgs.coreutils}/bin/cut -c 10-)"
            fi

            echo $icon
          '';
          exec-if = true;
          format = "<label> ";
          format-foreground = "\${colors.purple}";
        };
        "module/pulseaudio" = {
          type = "internal/pulseaudio";
          click-right = "pavucontrol";

          format-volume            = "<ramp-volume><label-volume>";
          format-volume-foreground = "\${colors.green}";
          label-volume             = "%percentage%%";
          label-volume-padding     = 1;

          format-muted-foreground     = "\${colors.red}";
          format-muted-prefix         = "";
          format-muted-prefix-padding = 1;
          label-muted                 = "Muted";
          label-muted-padding         = "\${self.label-volume-padding}";

          ramp-volume-0 = "";
          ramp-volume-1 = "";
          ramp-volume-2 = "";
          ramp-volume-3 = "";
          ramp-volume-4 = "";
          ramp-volume-5 = "";
          ramp-volume-6 = "";
          ramp-volume-padding = "1";
        };
        "module/cpu" = {
          type = "internal/cpu";
          interval = 1;
          format-padding = 1;
          format-prefix = "\" \"";
          format-foreground     = "\${colors.cyan}";
          label = "%percentage%%";
        };
        "module/memory" = {
          type = "internal/memory";
          interval = 1;
          format-padding = 1;
          format-prefix = "\" \"";
          format-foreground     = "\${colors.magenta}";
          label = "%percentage_used%%";
        };
        "module/battery" = {
          type = "internal/battery";

          full-at = 100;
          battery = "BAT0";
          adapter = "AC";

          poll-interval = 2;
          time-format = "%H:%M";

          format-charging            = "<animation-charging><label-charging>";
          format-charging-foreground = "\${colors.blue}";
          label-charging             = "%percentage%%";
          label-charging-padding     = 1;

          animation-charging-0 = "";
          animation-charging-1 = "";
          animation-charging-2 = "";
          animation-charging-3 = "";
          animation-charging-4 = "";
          animation-charging-padding   = 1;
          animation-charging-framerate = 750;

          format-discharging            = "<ramp-capacity><label-discharging>";
          format-discharging-foreground = "\${self.format-charging-foreground}";
          label-discharging             = "\${self.label-charging}";
          label-discharging-padding     = "\${self.label-charging-padding}";

          ramp-capacity-0 = "";
          ramp-capacity-1 = "";
          ramp-capacity-2 = "";
          ramp-capacity-3 = "";
          ramp-capacity-4 = "";
          ramp-capacity-padding = 1;

          format-full                = "<label-full>";
          format-full-foreground     = "\${self.format-charging-foreground}";
          format-full-prefix         = "";
          format-full-prefix-padding = 1;
          label-full                 = "\${self.label-charging}";
          label-full-padding         = "\${self.label-charging-padding}";
        };
        "module/temperature" = {
          type = "internal/temperature";
          thermal-zone = "4";
          warn-temperature = 60;

          format = "<ramp> <label>";
          format-overline = "\${colors.yellow}";
          format-warn = "<ramp> <label-warn>";
          format-warn-overline = "\${self.format-overline}";

          label = "%temperature-c%";
          label-warn = "%temperature-c%";
          label-warn-foreground = "\${colors.red}";

          ramp-0 = "";
          ramp-1 = "";
          ramp-2 = "";
          ramp-3 = "";
          ramp-4 = "";
          ramp-foreground = "\${colors.magenta}";
        };
        "settings" = {
          screenchange-reload = true;
        };
      };
      script = ''
      for m in $(${pkgs.xorg.xrandr}/bin/xrandr --query | ${pkgs.gnugrep}/bin/grep " connected" | ${pkgs.coreutils}/bin/cut -d" " -f1); do
        MONITOR=$m polybar --reload bar&
      done
      '';
      package = (pkgs.polybar.override { i3Support = true; alsaSupport = true; pulseSupport = true; });
    };
  };
}
