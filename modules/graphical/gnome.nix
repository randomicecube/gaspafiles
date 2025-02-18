# modules/graphical/gnome.nix
#
# gnome configuration.

# for reference, all available options can be found here:
# https://nix-community.github.io/home-manager/options.html
# heavily based on rafaelsgirao's config

{ pkgs, config, lib, colors, ... }:
let
  inherit (lib) mkEnableOption mkOption mkIf mkForce types;
  cfg = config.modules.graphical.gnome;
in
{
  options.modules.graphical.gnome = {
    enable = mkEnableOption "gnome";
  };
  imports = [
    ./pop-shell.nix
  ];
  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      epiphany # web browser
      gnome-tour
      xterm
      gedit
    ])
    ++ (with pkgs.gnome; [
      cheese
      gnome-music
      gnome-terminal
      geary # email reader evince # document viewer
      gnome-characters
      gnome-maps
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

    environment.systemPackages = with pkgs.gnome; [ gnome-tweaks dconf-editor ];
    programs.gnome-terminal.enable = false;

    hm =
      { lib, ... }:
      {
        programs.gnome-shell.enable = true;
        programs.gnome-shell.extensions = with pkgs.gnomeExtensions; [
          # { package = gsconnect; } # appears to be abandoned?
          # { package = valent; } # kde connect reimplementation - nixpkgs version not compatible w/ latest gnome
          { package = appindicator; }
          { package = caffeine; }
          # { package = cronomix; } # not compatible with cur. gnome
          { package = launch-new-instance; }
          { package = just-perfection; }
          # { package = pip-on-top; } # not compatible with cur. gnome
          { package = clipboard-history; }
          { package = blur-my-shell; }
        ];

        dconf.enable = true;
        dconf.settings = {
          "org/gnome/shell" = {
            disable-user-extensions = false;
            remember-mount-password = true;
          };
          # Use `dconf watch /` to track stateful changes you are doing, then set them here.
          "org/gnome/desktop/input-sources" = {
           sources = [
             (lib.hm.gvariant.mkTuple [
               "xkb"
                "us+altgr-intl"
             ])
             (lib.hm.gvariant.mkTuple [
               "xkb"
               "pt"
             ])
           ];
           xkb-options = [
              "ctrl:nocaps"
              "lv3:menu_switch" # reassigns menu key from panasonic to altgr
           ];
          };

          "org/gnome/settings-daemon/plugins/color" = {
            night-light-enabled = true;
            night-light-temperature = lib.hm.gvariant.mkUint32 2000;
            night-light-schedule-automatic = true;
          };
          "org/gnome/shell/app-switcher" = {
            current-workspace-only = false;
          };

          # "org/gnome/eog/ui" = { image-gallery = true; };
          "org/gnome/settings-daemon/plugins/power" = {
            sleep-inactive-battery-type = "suspend";
            sleep-inactive-battery-timeout = lib.hm.gvariant.mkUint32 900;
            sleep-inactive-ac-type = "nothing";
          };
          # };

          "org/gnome/shell/extensions/bedtime-mode".bedtime-mode-active = false;

          #TODO: would be cooler if these two were only enabled on laptops.
          "org/gnome/desktop/a11y".always-show-universal-access-status = lib.mkDefault true;
          "org/gnome/desktop/interface".text-scaling-factor = lib.mkDefault 1.25;

          "org/gnome/mutter" = {
            edge-tiling = lib.mkDefault true;
            workspaces-only-on-primary = false;
            dynamic-workspaces = false;
          };

          "org/gnome/desktop/wm/preferences" = {
            num-workspaces = 9;
            focus-mode = "sloppy";
          };
          # disable incompatible shortcuts
          #"org/gnome/mutter/wayland/keybindings" = {
            # restore the keyboard shortcuts: disable <super>escape
          #  restore-shortcuts = [ ];
          #};
          "org/gnome/desktop/wm/keybindings" =
            {
              # hide window: disable <super>h
              minimize = [ "<super>comma" ];
              # switch to workspace left: disable <super>left
              switch-to-workspace-left = [
                "<super>left"
                "<super>h"
              ];
              # switch to workspace right: disable <super>right
              switch-to-workspace-right = [
                "<primary><super>right"
                "<primary><super>l"
              ];
              # maximize window: disable <super>up
              maximize = [ ];
              # restore window: disable <super>down
              unmaximize = [ ];
              # move to monitor up: disable <super><shift>up
              move-to-monitor-up = [
                "<Shift><Super>Up"
                "<Shift><Super>k"
              ];
              # move to monitor down: disable <super><shift>down
              move-to-monitor-down = [
                "<Shift><Super>Down"
                "<Shift><Super>j"
              ];
              # super + direction keys, move window left and right monitors, or up and down workspaces
              # move window one monitor to the left
              move-to-monitor-left = [
                "<Shift><Super>Left"
                "<Shift><Super>h"
              ];
              # move window one workspace down
              move-to-workspace-down = [ ];
              # move window one workspace up
              move-to-workspace-up = [ ];
              # move window one monitor to the right
              move-to-monitor-right = [
                "<Shift><Super>Right"
                "<Shift><Super>l"
              ];
              # super + ctrl + direction keys, change workspaces, move focus between monitors
              # move to workspace below
              switch-to-workspace-down = [ ];
              # move to workspace above
              switch-to-workspace-up = [ ];
              # toggle maximization state
              toggle-maximized = [ "<super>m" ];
              # close window
              close = [ "<shift><super>q" ];
            }
            // (builtins.listToAttrs (
              lib.forEach (lib.range 1 9) (
                x: lib.nameValuePair "switch-to-workspace-${toString x}" [ "<Super>${toString x}" ]
              )
            ))
            // (builtins.listToAttrs (
              lib.forEach (lib.range 1 9) (
                x: lib.nameValuePair "move-to-workspace-${toString x}" [ "<Super><Shift>${toString x}" ]
              )
            ));
          "org/gnome/shell/keybindings" = {
            open-application-menu = [ ];
            # toggle message tray: disable <super>m
            toggle-message-tray = [ "<super>v" ];
            # show the activities overview: disable <super>s
            toggle-overview = [ "<super>p" ];

            switch-to-application-1 = [ ];
            switch-to-application-2 = [ ];
            switch-to-application-3 = [ ];
            switch-to-application-4 = [ ];
            switch-to-application-5 = [ ];
            switch-to-application-6 = [ ];
            switch-to-application-7 = [ ];
            switch-to-application-8 = [ ];
            switch-to-application-9 = [ ];
          };
          "org/gnome/mutter/keybindings" = {
            # disable tiling to left / right of screen
            toggle-tiled-left = [ ];
            toggle-tiled-right = [ ];
            # disable changing monitor displays with <super>p
            switch-monitor = [ ];
          };
          "org/gnome/settings-daemon/plugins/media-keys" = {
            # lock screen
            screensaver = [ "<super>x" ];
            # home folder
            # home = [ "<super>f" ];
            # launch email client
            # email = [ "<super>e" ];
            # # launch web browser
            # www = [ "<super>b" ];
            # rotate video lock
            rotate-video-lock-static = [ ];
            # launch terminal
            custom-keybindings = [
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/term/"
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/toggle_dnd/"
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch_flameshot/"
            ];
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/term" = {
            binding = "<super>return";
            command = "alacritty";
            name = "Launch terminal";
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/toggle_dnd" = {
            binding = "<super>j";
            command = "bash -c \"[[ $(gsettings get org.gnome.desktop.notifications show-banners) == 'false' ]] && gsettings set org.gnome.desktop.notifications show-banners true || gsettings set org.gnome.desktop.notifications show-banners false\"";
            name = "Toggle Do Not Disturb";
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch_flameshot" = {
            binding = "<super>Print";
            command = "flameshot gui";
            name = "Launch Flameshot";
          };
          # Configure Just Perfection
          "org/gnome/shell/extensions/just-perfection" = {
            animation = 2;
            dash-app-running = true;
            workspace = true;
            workspace-popup = false;
          };
          # Configure Blur My Shell
          "org/gnome/shell/extensions/blur-my-shell/appfolder".blur = false;
          "org/gnome/shell/extensions/blur-my-shell/lockscreen".blur = false;
          "org/gnome/shell/extensions/blur-my-shell/screenshot".blur = false;
          "org/gnome/shell/extensions/blur-my-shell/window-list".blur = false;
          "org/gnome/shell/extensions/blur-my-shell/panel".blur = false;
          "org/gnome/shell/extensions/blur-my-shell/overview".blur = true;
          "org/gnome/shell/extensions/blur-my-shell/overview".pipeline = "pipeline_default";
          "org/gnome/shell/extensions/blur-my-shell/dash-to-dock".blur = true;
          "org/gnome/shell/extensions/blur-my-shell/dash-to-dock".brightness = "0/6";
          "org/gnome/shell/extensions/blur-my-shell/dash-to-dock".sigma = 30;
          "org/gnome/shell/extensions/blur-my-shell/dash-to-dock".static-blur = true;
          "org/gnome/shell/extensions/blur-my-shell/dash-to-dock".style-dash-to-dock = 0;
          # Make thunderbird the default calendar
          "org/gnome/desktop/default-applications/calendar" = {
            exec = "thunderbird.desktop";
          };
        };
      };
  };
}
