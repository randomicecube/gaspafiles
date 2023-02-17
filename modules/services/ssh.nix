# modules/services/ssh.nix
#
# SSH configuration

{ config, options, lib, pkgs, sshKeys, ... }:

with lib;
let cfg = config.modules.services.ssh; in
{
  options.modules.services.ssh = {
    enable = mkEnableOption "SSH Key Management";

    host = {
      name = mkOption {
        type = types.str;
        default = config.networking.hostName;
        description = "SSH host name";
      };
      key = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "SSH host key";
      };
    };

    allHosts = mkOption {
      type = types.attrsOf (types.nullOr types.str);
    };

    user = {
      name = mkOption {
        type = types.str;
        default = "${config.usr.name}@${config.networking.hostName}";
        description = "SSH user name";
      };
      key = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "SSH user key";
      };
    };

    allUsers = mkOption {
      type = types.attrsOf (types.nullOr types.str);
    };

    allowSSHAgentAuth = mkEnableOption "SSH agent authentication";

    preferAskPassword = mkEnableOption "Prefer ASKPASS";

    manageKnownHosts = {
      enable = mkEnableOption "SSH hosts management";
      extraHosts = mkOption {
        type = types.attrsOf types.str;
        default = { };
        description = "Extra known_hosts";
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = [ pkgs.openssh ];

      services.openssh = {
        enable = true;
        passwordAuthentication = false;
        authorizedKeysFiles = lib.mkForce [ "/etc/ssh/authorized_keys.d/%u" ];
        kbdInteractiveAuthentication = false;
      };

      programs.ssh = {
        startAgent = true;
        agentTimeout = "1h";
        extraConfig = ''
          AddKeysToAgent yes
        '';
      };

      systemd.user.services.ssh-agent.serviceConfig.Restart = lib.mkForce "always";
      systemd.services.lock-ssh-agent = {
        enable = true;
        description = "Lock SSH Agent";
        wantedBy = [ "suspend.target" "hibernate.target" ];
        before = [ "systemd-suspend.service" "systemd-hibernate.service" "systemd-suspend-then-hibernate.service" ];
        serviceConfig = {
          ExecStart = "${pkgs.killall}/bin/killall ssh-agent";
          Type = "forking";
        };
      };
    }
    (mkIf cfg.manageKnownHosts.enable {
      programs.ssh.knownHosts = mapAttrs (_: v: { publicKey = v; }) (sshKeys // cfg.manageKnownHosts.extraHosts);
      programs.ssh.extraConfig = concatMapStringsSep "\n"
        (host: ''
          Host ${host}
            User ${config.usr.name}
            ${optionalString (config.networking.domain != null) "HostName ${host}.${config.networking.domain}"}
            ${optionalString cfg.allowSSHAgentAuth "ForwardAgent yes"}
        '')
        (attrNames sshKeys);
    })
    (mkIf cfg.allowSSHAgentAuth {
      security = {
        sudo.enable = true;
        pam.enableSSHAgentAuth = true;
        pam.services.sudo.sshAgentAuth = true;
      };
    })
  ]);
}