# hosts/clockwerk/system.nix
#
# System configuration for clockwerk (dsi).

{ pkgs, lib, sshKeys, config, hostSecretsDir, user, agenixPackage, ... }: {

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

  networking.hostId = "239be557";
  zramSwap.enable = true;

  environment.persistence."/persist" = {
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/docker"
      "/var/lib/libvirt"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };


  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    authorizedKeysFiles = lib.mkForce [ "/etc/ssh/authorized_keys.d/%u" ];
    kbdInteractiveAuthentication = false;
  };

  security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };

  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.prime = {
  #   offload.enable = true;

  #   intelBusId = "PCI:0:2:0";
  #   nvidiaBusId = "PCI:2:0:0";
  # };
  # services.xserver.screenSection = ''
  #   Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
  #   Option         "AllowIndirectGLXProtocol" "off"
  #   Option         "TripleBuffer" "on"
  # '';

  modules = {
    graphical.enable = true;
    personal.enable = true;
  };

  # environment.systemPackages = let
  #   nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
  #     export __NV_PRIME_RENDER_OFFLOAD=1
  #     export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  #     export __GLX_VENDOR_LIBRARY_NAME=nvidia
  #     export __VK_LAYER_NV_optimus=NVIDIA_only
  #     exec "$@"
  #   '';
  # in ([ nvidia-offload ]);

  users = {
    mutableUsers = false;
    users = {
      ${user} = {
        hashedPassword = "$y$j9T$2wDkcLN6AlpFD4P1WX0zU0$FLDV6SZb/7ZHl3lKzlEE3D2qyVr3p/gJhuwKQ7w95V0";
        openssh.authorizedKeys.keys = sshKeys;
        extraGroups = [ "networkmanager" ];
      };
    };
  };

  virtualisation.docker.enable = true;

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
  #   cert = config.age.secrets.bentleyNebulaCert.path;
  #   key = config.age.secrets.bentleyNebulaKey.path;
  # };
}