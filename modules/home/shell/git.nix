# modules/home/shell/git.nix
#
# Git configuration. (Based on RageKnify's)

{ lib, config, configDir, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.shell.git;
in {
  options.modules.shell.git.enable = mkEnableOption "git";

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Diogo Gaspar";
      userEmail = "diogo@gaspa.pt";
      extraConfig = {
        diff.tool = "vimdiff";
        init.defaultBranch = "master";
        pull.rebase = true;
        url."git@github.com:".pushinsteadOf = "https://github.com/";
        commit.template = "${configDir}/gitmessage.txt";
        commit.verbose = true;
      };
      includes = [{
        condition = "gitdir:~/dsi/|gitdir:~/tecas/";
        contents.user = {
          name = "Diogo Gaspar";
          email = "diogo.marques.gaspar@tecnico.ulisboa.pt";
        };
      }];
    };
  };
}

