# modules/home/graphical/i3.nix
#
# i3 configuration.

# for reference, all available options can be found here:
# https://nix-community.github.io/home-manager/options.html

{ pkgs, config, lib, hostName, colors, configDir, ... }:
let
  inherit (lib) mkEnableOption mkIf mkForce;
  cfg = config.modules.graphical.i3;
  i3Mod = "Mod4";
  i3Pkg = pkgs.i3-gaps;
in
{
  options.modules.graphical.i3.enable = mkEnableOption "i3";

  config = mkIf cfg.enable {
    home.pointerCursor = {
      package = pkgs.quintom-cursor-theme;
      name = "Quintom_Ink";
      size = 28;
      x11.enable = true;
    };
    xsession = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        package = i3Pkg;
        config = {
          modifier = i3Mod;

          focus.newWindow = "urgent";

          keybindings = lib.mkOptionDefault {
            "${i3Mod}+Tab"       = "workspace next";
            "${i3Mod}+Shift+Tab" = "workspace prev";

            "${i3Mod}+s"        = "gaps inner current plus 5";
            "${i3Mod}+Shift+s"  = "gaps inner current minus 5";

            "${i3Mod}+Shift+x"     = "restart";
            "${i3Mod}+Shift+r"     = "reload";
            "${i3Mod}+Ctrl"        = "mode \"resize\"";

            "${i3Mod}+Left"   = "focus left";
            "${i3Mod}+Down"   = "focus down";
            "${i3Mod}+Up"     = "focus up";
            "${i3Mod}+Right"  = "focus right";

            "${i3Mod}+Shift+Left"   = "move left";
            "${i3Mod}+Shift+Down"   = "move down";
            "${i3Mod}+Shift+Up"     = "move up";
            "${i3Mod}+Shift+Right"  = "move right";

            "${i3Mod}+Shift+1" = "move container to workspace 1; workspace 1";
            "${i3Mod}+Shift+2" = "move container to workspace 2; workspace 2";
            "${i3Mod}+Shift+3" = "move container to workspace 3; workspace 3";
            "${i3Mod}+Shift+4" = "move container to workspace 4; workspace 4";
            "${i3Mod}+Shift+5" = "move container to workspace 5; workspace 5";
            "${i3Mod}+Shift+6" = "move container to workspace 6; workspace 6";
            "${i3Mod}+Shift+7" = "move container to workspace 7; workspace 7";
            "${i3Mod}+Shift+8" = "move container to workspace 8; workspace 8";
            "${i3Mod}+Shift+9" = "move container to workspace 9; workspace 9";
            "${i3Mod}+Shift+0" = "move container to workspace 10; workspace 10";
          };

          modes = {
            resize = {
              Escape = "mode default";
              Left  = "resize shrink width 5 px or 5 ppt";
              Down  = "resize grow height 5 px or 5 ppt";
              Up    = "resize shrink height 5 px or 5 ppt";
              Right = "resize grow width 5 px or 5 ppt";
            };
          };

          colors  = with colors.dark; {
            focused = {
              border = "${base05}";
              background = "${base00}";
              text = "${base05}";
              indicator = "${base05}";
              childBorder = "${base05}";
            };
            focusedInactive = {
              border = "${base01}";
              background = "${base01}";
              text = "${base05}";
              indicator = "${base03}";
              childBorder = "${base01}";
            };
            unfocused = {
              border = "${base01}";
              background = "${base00}";
              text = "${base05}";
              indicator = "${base01}";
              childBorder = "${base01}";
            };
            urgent = {
              border = "${base08}";
              background = "${base08}";
              text = "${base00}";
              indicator = "${base08}";
              childBorder = "${base08}";
            };
            placeholder = {
              border = "${base00}";
              background = "${base00}";
              text = "${base05}";
              indicator = "${base00}";
              childBorder = "${base00}";
            };
            background = "${base07}";
          };

          fonts = {
            names = [ "JetBrains Mono Nerd Font" ];
            style = "Bold Semi-Condensed";
            size = 14.0;
          };

          menu = "${pkgs.rofi}/bin/rofi -show drun";
          window = {
            hideEdgeBorders = "both";
          };

          gaps = {
            inner = 6;
            outer = 6;
            top = 3;
            bottom = 3;
            smartBorders = "on";
          };

          assigns = {
            "2" = [{ class = "discord"; }];
            "3" = [{ class = "spotify"; }];
            "4" = [{ class = "thunderbird"; }];
          };

          bars = [];

          startup = [
            { command = "nm-applet"; notification = false; }
            {
              command = "${pkgs.systemd}/bin/systemctl --user start graphical-session-i3.target";
              notification = false;
            }
            { command = "clipit &"; notification = false; }
            { command = "discord"; notification = false; }
            { command = "spotify"; notification = false; }
            { command = "thunderbird"; notification = false; }
          ];

          workspaceAutoBackAndForth = true;
          floating.modifier = "${i3Mod}";
        };
        extraConfig = ''
          for_window [class="Spotify"] move to workspace 3
        '';
      };
    };
    systemd.user.targets.graphical-session-i3 = {
      Unit = {
        Description = "i3 X session";
        BindsTo = [ "graphical-session.target" ];
        Requisite = [ "graphical-session.target" ];
      };
    };

    services.picom = {
      enable = false;
      vSync = true;
      backend = "glx";
    };

    services.dunst.enable = true;
    xdg.configFile."dunst/dunstrc".source = "${configDir}/dunstrc";

    services.random-background = {
      enable = true;
      enableXinerama = true;
      display = "fill";
      # the wallpapers directory contains more folders with different wallpaper themes
      imageDirectory = "${configDir}/utils/wallpapers/mandelbrot";
      interval = "1h";
    };
  };
}

