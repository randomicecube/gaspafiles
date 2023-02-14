# modules/home/graphical/alacritty.nix
#
# alacritty configuration, copied from rageknify.

{ lib, config, colors, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical.alacritty;
in
{
  options.modules.graphical.alacritty.enable = mkEnableOption "alacritty";

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 11;
        window = {
          padding = {
            x = 8;
            y = 8;
          };
        };
        key_bindings = [
          { key = "C"; mods = "Alt"; action = "Copy"; }
          { key = "V"; mods = "Alt"; action = "Paste"; }
        ];
        colors = with colors.dark; {
            primary = {
              background = "${base00}";
              foreground = "${base05}";
            };

            # Colors the cursor will use if `custom_cursor_colors` is true
            cursor = {
              text   = "${base00}";
              cursor = "${base05}";
            };

            # Normal colors
            normal =  {
              black   = "${base01}";
              red     = "${base09}";
              green   = "${base0B}";
              yellow  = "${base0A}";
              blue    = "${base0D}";
              magenta = "${base0E}";
              cyan    = "${base0C}";
              white   = "${base06}";
            };

            # Bright colors
            bright = {
              black   = "${base01}";
              red     = "${base08}";
              green   = "${base0B}";
              yellow  = "${base0A}";
              blue    = "${base0D}";
              magenta = "${base03}";
              cyan    = "${base04}";
              white   = "${base07}";
            };

            indexed_colors = [
               { index = 16; color = "${base09}"; }
               { index = 17; color = "${base0F}"; }
               { index = 18; color = "${base01}"; }
               { index = 19; color = "${base02}"; }
               { index = 20; color = "${base04}"; }
               { index = 21; color = "${base06}"; }
            ];
        };
      };
    };
    xsession.windowManager.i3.config.terminal = "alacritty";
    home.sessionVariables.TERMINAL = "alacritty";
  };
}
