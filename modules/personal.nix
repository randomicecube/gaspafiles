# modules/personal.nix
#
# personal home configuration.

{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.personal;
in {
  options.modules.personal.enable = mkEnableOption "personal";

  config = mkIf cfg.enable {
    hm.home.packages = with pkgs;[
      # calc
      libqalculate
      # LaTeX
      texlive.combined.scheme-full
      texlab
      # Rust
      rustup
      pkgs.unstable.rust-analyzer
      # GCC
      gcc
      # Make
      gnumake
    ];

    hm.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # to login into Fenix with Kerberos, on Firefox's about:config
    # network.negotiate-auth.trusted-uris	= id.tecnico.ulisboa.pt
    krb5 =  {
      enable = true;
      libdefaults = {
        default_realm = "IST.UTL.PT";
        kdc_timesync = 1;
        ccache_type = 4;
        forwardable = true;
        proxiable = true;
      };
      domain_realm = {
        "ist.utl.pt" = "IST.UTL.PT";
        ".ist.utl.pt" = "IST.UTL.PT";
      };
      realms = {
        "IST.UTL.PT" = {
          admin_server = "kerberosmaster.ist.utl.pt";
        };
      };
    };

    # Printer
    services.printing.enable = true;
    services.printing.drivers = with pkgs; [
      gutenprint
      gutenprintBin
    ];

    # SSH stuff
    programs.ssh = {
      startAgent = true;
    };
  };
}

