# modules/system/graphical.nix
#
# Login manager and graphical configuration.

{ pkgs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical;
in
{
  options.modules.graphical = {
    enable = mkEnableOption "graphical";
  };

  config = mkIf cfg.enable {
    hm.services.redshift = {
      enable = true;
      temperature = {
        day = 4000;
        night = 3000;
      };
      latitude = 38.743;
      longitude = -9.195;
    };

    # Required for gtk. (copied from RiscadoA)
    services.dbus.packages = [ pkgs.dconf ];

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
      xclip
      xcape

      pavucontrol
      polkit_gnome
      i3lock-color
      rofi-power-menu
      rofi-bluetooth
      haskellPackages.greenclip

      feh
      firefox
      brave
      libreoffice
      zathura
      xfce.thunar
      evince
      xournalpp
    ];

    services.gnome.gnome-keyring.enable = true;

    # TODO: laptop only
    programs.light.enable = true;
    programs.nm-applet.enable = true;
  };
}

