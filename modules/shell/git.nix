# modules/shell/git.nix
#
# Git configuration. (Based on RageKnify's + luishfonseca's)
# Reference for signing commits: https://jeppesen.io/git-commit-sign-nix-home-manager-ssh/

{ lib, config, configDir, ... }:
let
  inherit (lib) mkEnableOption mkOption mkMerge mkIf types;
  cfg = config.modules.shell.git;
in {
  options.modules.shell.git = {
    enable = mkEnableOption "git";
    commits = {
      name = mkOption {
        type = types.str;
        default = "Diogo Gaspar";
      };
      email = mkOption {
        type = types.str;
        default = "diogo@gaspa.pt";
      };
      signingkey = mkOption {
        type = types.nullOr types.str;
        default = if config.modules.services.ssh.enable then config.modules.services.ssh.user.key else null;
      };
    };
  };

  config.hm = mkIf cfg.enable (mkMerge [{
    programs.git = {
      enable = true;
      extraConfig = {
        init.defaultBranch = "master";
        url."git@github.com:".insteadOf = "https://github.com/";
        user = {
          name = cfg.commits.name;
          email = cfg.commits.email;
        };
        diff.tool = "vimdiff";
        pull.rebase = true;
        commit.template = "${configDir}/gitmessage.txt";
        commit.verbose = true;
      };
      includes = [
      {
        condition = "gitdir:~/dsi/|gitdir:~/tecas/";
        contents.user = {
          name = "Diogo Gaspar";
          email = "diogo.marques.gaspar@tecnico.ulisboa.pt";
        };
      }
      {
        condition = "gitdir:~/kth/";
        contents.user = {
          name = "Diogo Gaspar";
          email = "dgaspar@kth.se";
        };
      }
      ];
    };
  }
  (mkIf (cfg.commits.signingkey != null) {
    config.programs.git = {
      signing = {
        key = cfg.commits.signingkey;
        signByDefault = true;
      };
      extraConfig = {
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
    };
  })
  ]);
}

