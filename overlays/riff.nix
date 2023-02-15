# overlays/riff.nix
#
# Have access to riff

{ inputs, ... }:
final: prev: rec {
  riff = inputs.riff.defaultPackage.x86_64-linux;
}

