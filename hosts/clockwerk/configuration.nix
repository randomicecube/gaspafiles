# hosts/clockwerk/configuration.nix

# Configuration for clockwerk (dsi desktop)

{ pkgs, lib, sshKeys, config, hostSecretsDir, user, ... }: {
  # Boot stuff
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 10;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    supportedFilesystems = [ "zfs" ];
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [ "nohibernate" ];
    tmpOnTmpfs = true;
    tmpOnTmpfsSize = "80%";
    cleanTmpDir = true;
  };

  networking.nameservers = [ "1.0.0.1" "1.1.1.1" ];
  networking.hostId = "ea68da8f";

  zramSwap.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    authorizedKeysFiles = lib.mkForce [ "/etc/ssh/authorized_keys.d/%u" ];
    kbdInteractiveAuthentication = false;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.docker.enable = true;
  # virtualisation.libvirtd.enable = true;

  # Secret manager
  # age = {
  #   secrets = {
  #     bacchusNebulaCert.file = "${hostSecretsDir}/nebulaCert.age";
  #     bacchusNebulaKey.file = "${hostSecretsDir}/nebulaKey.age";
  #   };

  #   identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  # };

  # modules.nebula = {
  #   enable = true;
  #   cert = config.age.secrets.clockwerkNebulaCert.path;
  #   key = config.age.secrets.clockwerkNebulaKey.path;
  # };

  # Home config
  modules = {
    editors.neovim.enable = true;
    graphical.enable = true;
    graphical.alacritty.enable = true;
    graphical.dev.enable = true;
    graphical.gtk.enable = true;
    graphical.i3.enable = true;
    graphical.polybar.enable = true;
    graphical.programs.enable = true;
    graphical.rofi.enable = true;
    graphical.spotify.enable = true;
    graphical.sxhkd.enable = true;
    graphical.zathura.enable = true;
    personalk.enable = true;
    services.gpg.enable = true;
    services.ssh.enable = true;
    shell = {
      git.enable = true;
      zsh.enable = true;
    };
    xdg.enable = true;
  };

  hm.home.packages = with pkgs;
    [
      # Add packages here.
    ];
  
  system.stateVersion = "22.11";
}