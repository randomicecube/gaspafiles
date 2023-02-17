# modules/shell/zsh.nix
#
# zsh (with oh-my-zsh) configuration.

{ pkgs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.shell.zsh;
in {
  options.modules.shell.zsh.enable = mkEnableOption "zsh";

  config.hm = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "docker-compose" "zoxide" ];
      };
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
          };
        }
        {
          name = "zsh-completions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-completions";
            rev = "0.34.0";
            sha256 = "0jjgvzj3v31yibjmq50s80s3sqi4d91yin45pvn3fpnihcrinam9";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.0";
            sha256 = "0s1z3whzwli5452h2yzjzzj27pf1hd45g223yv0v6hgrip9f853r";
          };
        }
        # TODO: add zsh-nvm
      ];
      # FIXME this isn't working correctly on neovim.nix
      initExtra = ''
        export EDITOR=nvim
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
      shellAliases = {
        clip = "xclip -sel clip";
        gac = "git add . && git commit -m";
        ls = "exa";
      };
    };

    # exa (modern ls replacement)
    programs.exa.enable = true;
    # bat (modern cat replacement)
    programs.bat.enable = true;

    # starship (shell theme)
    programs.starship.package = pkgs.unstable.starship;
    programs.starship.enable = true;
    # zoxide (jump to directories)
    programs.zoxide.enable = true;
    home.sessionVariables._ZO_ECHO = "1";

    programs.starship.settings = {
      scan_timeout = 1;
      add_newline = true;

      username.format = "[$user]($style) in ";
      hostname = {
        ssh_only = true;
        format = "[$hostname]($style) ";
      };
    };
  };
}

