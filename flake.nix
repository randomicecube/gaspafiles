# flake.nix
#
# My config, shamelessly based on diogotcorreia's

{
  description = "Nix configuration for PCs and servers.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-latest.url = "github:nixos/nixpkgs/master";
    riff = {
      url = "github:DeterminateSystems/riff/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-osc52 = {
      url = "github:ojroques/nvim-osc52/main";
      flake = false;
    };
    digga = {
      url = "github:divnix/digga";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
        nixlib.follows = "nixpkgs";
        home-manager.follows = "home";
      };
    };
    mach-nix.url = "mach-nix";
  };

  outputs = inputs@{ self, ... }:
    let
      inherit (builtins) listToAttrs concatLists attrValues attrNames readDir;
      inherit (inputs.nixpkgs) lib;
      inherit (lib) mapAttrs mapAttrsToList hasSuffix;
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIPXnaZy4Pk+3qL6dx4iBnPCLTpGgf8yzhkPe1AcR+/K gaspa@sly"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFgZUGgluhhI6Pg+LCp70WCy2YX12of8Cc6cO6JQJDzy gaspa@clockwerk"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII2XabbFMuMGrsHJRhj/91KlrFNWSgnSn5qNfufzqHeA gaspa@bentley"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDBERhm3T9/a1UjVeG+HQWaa6BR/pV3S/NUG8cKM78Ij gaspa@murray"
      ];
      # for signing git commits
      allowedSigners = builtins.concatStringsSep"\n" (map (key: "* ${key}") sshKeys);

      colors = {
        # adapted from RageKnify's
        dark = {
          "base00" = "#181825"; # background
          "base01" = "#45475a"; # lighter background
          "base02" = "#624f82"; # selection background
          "base03" = "#f38ba8"; # comments, invisibles, line highlighting
          "base04" = "#89b4fa"; # dark foreground
          "base05" = "#cdd6f4"; # default foreground
          "base06" = "#eee8d5"; # light foreground
          "base07" = "#fdf6e3"; # light background
          "base08" = "#dc322f"; # red       variables
          "base09" = "#cb4b16"; # orange    integers, booleans, constants
          "base0A" = "#b58900"; # yellow    classes
          "base0B" = "#859900"; # green     strings
          "base0C" = "#2aa198"; # aqua      support, regular expressions
          "base0D" = "#268bd2"; # blue      functions, methods
          "base0E" = "#6c71c4"; # purple    keywords, storage, selector
          "base0F" = "#d33682"; # deprecated, opening/closing embedded language tags
        };
        light = {
          "base00" = "#fdf6e3";
          "base01" = "#eee8d5";
          "base02" = "#cdd6f4";
          "base03" = "#89b4fa";
          "base04" = "#f38ba8";
          "base05" = "#624f82";
          "base06" = "#45475a";
          "base07" = "#181825";
          "base08" = "#dc322f";
          "base09" = "#cb4b16";
          "base0A" = "#b58900";
          "base0B" = "#859900";
          "base0C" = "#2aa198";
          "base0D" = "#268bd2";
          "base0E" = "#6c71c4";
          "base0F" = "#d33682";
        };
      };
      hostNameToColor = hostName:
        let
          mapping = {
            sly = "base08";
            bentley = "base09";
            clockwerk = "base10";
          };
          base = mapping."${hostName}";
        in colors.light."${base}";

      system = "x86_64-linux";
      user = "gaspa";

      permittedInsecurePackages = [ "electron-25.9.0" ];

      pkg-sets = final: prev:
        let
          args = {
            system = final.system;
            config.allowUnfree = true;
          };
        in {
          unstable = import inputs.nixpkgs-unstable args;
          latest = import inputs.nixpkgs-latest args;
        };

      secretsDir = ./secrets;

      overlaysDir = ./overlays;

      overlays = [ pkg-sets ] ++ mapAttrsToList
        (name: _: import "${overlaysDir}/${name}" { inherit inputs; })
        (readDir overlaysDir);

      pkgs = import inputs.nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };

      agenixPackage = inputs.agenix.packages.${system}.default;
      spicetifyPkgs = inputs.spicetify-nix.packages.${system}.default;

      allModules = mkModules ./modules;

      # Imports every nix module from a directory, recursively.
      mkModules = dir:
        concatLists (attrValues (mapAttrs (name: value:
          if value == "directory" then
            mkModules "${dir}/${name}"
          else if value == "regular" && hasSuffix ".nix" name then
            [ (import "${dir}/${name}") ]
          else
            [ ]) (readDir dir)
        ));

      profiles = inputs.digga.lib.rakeLeaves ./profiles;

      # Imports every host defined in a directory.
      mkHosts = dir:
        listToAttrs (map (name: {
          inherit name;
          value = inputs.nixpkgs.lib.nixosSystem {
            inherit system pkgs;
            specialArgs = {
              inherit inputs user colors profiles sshKeys allowedSigners agenixPackage secretsDir spicetifyPkgs;
              configDir = ./config;
              hostSecretsDir = "${secretsDir}/${name}";
              hostName = name;
            };
            modules = [
              { networking.hostName = name; }
              (dir + "/${name}/hardware.nix")
              (dir + "/${name}/configuration.nix")
              inputs.home.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [ inputs.spicetify-nix.homeManagerModule ];
                };
              }
              inputs.agenix.nixosModules.age
            ] ++ allModules;
          };
        }) (attrNames (readDir dir)));

    in { nixosConfigurations = mkHosts ./hosts; };
}
