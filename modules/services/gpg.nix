# modules/services/gpg.nix
#
# Not actually a service, but we can pretend it is
# Stolen from luishfonseca

{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.services.gpg; in
{
  options.modules.services.gpg = with types; {
    enable = mkEnableOption "GnuPG";

    sshKeys = mkOption {
      type = nullOr (listOf str);
      default = null;
      description = ''
        Which GPG keys (by keygrip) to expose as SSH keys.
      '';
    };
  };

  config.hm = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };
}