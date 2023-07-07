# profiles/graphical/all.nix
#
# Login manager and graphical programs configuration

{ pkgs, config, lib, user, colors, configDir, profiles, ... }:
let
  cfg = profiles.graphical.all;
in {
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
    displayManager = {
      defaultSession = "user-xsession";
      session = [
        {
          name = "user-xsession";
          manage = "desktop";
          bgSupport = true; # allows for the random background service to work
          start = ''
          exec $HOME/.xsession
          '';
        }
      ];
      lightdm = {
        enable = true;
        extraConfig = ''
          set logind-check-graphical=true
        '';
        greeters.gtk = {
          enable = true;
          theme = {
            package = pkgs.rose-pine-gtk-theme;
            name = "rose-pine";
          };
          iconTheme = {
            package = pkgs.papirus-icon-theme;
            name = "Papirus-Dark";
          };
        };
      };
    };
  };

  hm = {
    home.pointerCursor = {
      package = pkgs.quintom-cursor-theme;
      name = "Quintom_Ink";
      size = 28;
      x11.enable = true;
    };

    services.redshift = {
      enable = true;
      temperature = {
        day = 4000;
        night = 3000;
      };
      # TODO: change this to stockholm ;-;
      latitude = 38.743;
      longitude = -9.195;
    };

    systemd.user.targets.graphical-session-i3 = {
      Unit = {
        Description = "i3 X session";
        BindsTo = [ "graphical-session.target" ];
        Requisite = [ "graphical-session.target" ];
      };
    };

    services.picom = {
      enable = false; # currently broken?
      vSync = true;
      backend = "glx";
    };

    services.flameshot = {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          startupLaunch = false;
          antialiasingPinZoom = true;
        };
      };
    };

    services.dunst.enable = true;
    xdg.configFile."dunst/dunstrc".source = "${configDir}/dunstrc";

    services.random-background = {
      enable = true;
      enableXinerama = true;
      display = "fill";
      # FIXME: un-hardcode this
      imageDirectory = "%h/Documents/wallpapers/mandelbrot";
      interval = "60m";
    };
  };

  # Required for gtk. (copied from RiscadoA)
  services.dbus.packages = [ pkgs.dconf ];
  programs.dconf.enable = true;

  fonts.fonts = with pkgs; [
    fira-code
    font-awesome
    material-design-icons
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    noto-fonts-extra
    meslo-lgs-nf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  # rtkit is optional but recommended
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    xorg.xkbcomp
    xorg.xmodmap
    xclip
    xcape

    pavucontrol
    polkit_gnome
    i3lock-color
    rofi-power-menu
    rofi-bluetooth
    haskellPackages.greenclip

    arandr
    feh
    firefox
    brave
    libreoffice
    zathura
    xfce.thunar
    evince
    xournalpp
    xf86_input_wacom
  ];

  services.gnome.gnome-keyring.enable = true;
}
