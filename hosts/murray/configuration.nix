# hosts/murray/configuration.nix

# Configuration for murray ("practice" VM)

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

  # environment.persistence."/persist" = {
  #   directories = [
  #     "/etc/NetworkManager/system-connections"
  #     "/var/lib/docker"
  #     "/var/lib/libvirt"
  #     "/var/log"
  #   ];
  #   files = [
  #     "/etc/machine-id"
  #     "/etc/ssh/ssh_host_ed25519_key"
  #     "/etc/ssh/ssh_host_ed25519_key.pub"
  #   ];
  # };

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

  #   identityPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
  # };

  # modules.nebula = {
  #   enable = true;
  #   cert = config.age.secrets.murrayNebulaCert.path;
  #   key = config.age.secrets.murrayNebulaKey.path;
  # };

  # Home config
  modules = {
    editors = {
      neovim.enable = true;
    };
    graphical = {
      enable = true;
      alacritty.enable = true;
      dev.enable = true;
      gtk.enable = true;
      i3.enable = true;
      polybar.enable = true;
      programs.enable = true;
      rofi.enable = true;
      spotify.enable = true;
      sxhkd.enable = true;
      zathura.enable = true;
    };
    personal.enable = true;
    services = {
      gpg.enable = true;
      ssh.enable = true;
    };
    shell = {
      git.enable = true;
      zsh.enable = true;
    };
    xdg.enable = true;
  };

  modules.services.ssh = {
    host.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEjTbKMa1jh2AfcA5WUMrm+SfLHqsbpYzSV5QpdmxVew";
    user.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDBERhm3T9/a1UjVeG+HQWaa6BR/pV3S/NUG8cKM78Ij";
    allowSSHAgentAuth = true;
    # manageKnownHosts.enable = true;
  };

  hm.home.packages = with pkgs;
    [
      # Add packages here.
    ];
  
  system.stateVersion = "22.11";
}