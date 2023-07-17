# modules/graphical/zathura.nix
#
# PDF viewer

{ pkgs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical.zathura;
in {
  options.modules.graphical.zathura.enable = mkEnableOption "zathura";

  config.hm = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
        recolor = "true"; # open documents with inverted colors by default
        recolor-keephue = "true";
        sandbox = "none"; # fix links not opening on browser
      };
      extraConfig = ''
        # Change 'recolor' and 'recolor-keephue' to true to change
        # the document colors for a more uniform viewing experience.

        # This is the Rosé Pine Moon theme!

        set default-bg                  "#232136"
        set default-fg                  "#e0def4"

        set statusbar-fg                "#e0def4"
        set statusbar-bg                "#59546d"

        set inputbar-bg                 "#817c9c"
        set inputbar-fg                 "#232136"

        set notification-bg             "#817c9c"
        set notification-fg             "#232136"

        set notification-error-bg       "#817c9c"
        set notification-error-fg       "#ea9a97"

        set notification-warning-bg     "#817c9c"
        set notification-warning-fg     "#f6c177"

        set highlight-color             "#3e8fb0"
        set highlight-active-color      "#9ccfd8"

        set completion-bg               "#817c9c"
        set completion-fg               "#9ccfd8"

        set completion-highlight-fg     "#e0def4"
        set completion-highlight-bg     "#9ccfd8"

        set recolor-lightcolor          "#232136"
        set recolor-darkcolor           "#e0def4"

        set recolor                     "false"
        set recolor-keephue             "false"
      '';
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        # Use Zathura as default PDF viewer
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      };
    };
  };
}

