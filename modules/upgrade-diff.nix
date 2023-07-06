# modules/upgrade-diff.nix
#
# Shows new versions on rebuild upgrade

{ pkgs, ... }: {
  system.activationScripts.diff = ''
   ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
  '';
}
