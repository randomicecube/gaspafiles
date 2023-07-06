# hosts/bentley/configuration.nix

# Configuration for bentley (laptop)

{ pkgs, lib, sshKeys, allowedSigners, config, secretsDir, user, profiles, ... }: {
  imports = with profiles; [ common graphical.all graphical.laptop ];

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
      };
    };
    kernelPackages = pkgs.linuxPackages_xanmod;
    kernelParams = [ "nohibernate" ];
  };

  networking.nameservers = [ "1.0.0.1" "1.1.1.1" ];
  networking.hostId = "988e8aaa";
  networking.networkmanager.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.blueman.enable = config.hardware.bluetooth.enable;
  hardware.bluetooth.enable = true;

  # Battery saver
  services.tlp.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  # Secret manager
  age = {
    secrets = {
      slyMachineAddress.file = "${secretsDir}/slyMachineAddress.age";
    };

    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };

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
      qt.enable = true;
      rofi.enable = true;
      spotify.enable = true;
      sxhkd.enable = true;
      zathura.enable = true;
    };
    personal.enable = true;
    services = {
      ssh = {
        enable = true;
        host.key = "/etc/ssh/ssh_host_ed25519_key.pub";
        user.key = "~/.ssh/id_ed25519.pub";
        allowSSHAgentAuth = true;
        # manageKnownHosts.enable = true;
      };
    };
    shell = {
      git.enable = true;
      zsh.enable = true;
    };
    xdg.enable = true;
  };

  hm.home.file.".ssh/allowed_signers".text = "${allowedSigners}";

  hm.home.packages = with pkgs;
    [
      # Add packages here.
    ];

  system.stateVersion = "23.05";
}
