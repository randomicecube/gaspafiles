# modules/ist.nix
#
# (Stolen from) Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# Configuration for services and programs needed while studying
# at Técnico Lisboa (IST).

{ pkgs, config, lib, secretsDir, ... }:
let
  inherit (lib) mkEnableOption mkIf escapeShellArg getAttr attrNames;
  cfg = config.modules.ist;

  istVpnConfiguration = pkgs.fetchurl {
    #url =
    #  "https://suporte.dsi.tecnico.ulisboa.pt/sites/default/files/files/tecnico.ovpn";
    sha256 = "sha256-3vQ5eyrB2IEKHJXXDJk3kPXRbNwGsRpcN8hmPl7ihBQ=";
  };
in {
  options.modules.ist.enable = mkEnableOption "ist";

  config = mkIf cfg.enable {
    # TODO: kerberos?
    # OpenVPN
    age.secrets.openvpnIstAuthUserPass.file =
      "${secretsDir}/openvpnIstAuthUserPass.age";
    #services.openvpn.servers.ist = {
    #  autoStart = false;
    #  config = ''
    #    config ${istVpnConfiguration}
    #    auth-user-pass ${config.age.secrets.openvpnIstAuthUserPass.path}
    #  '';
    #};
  };
}

