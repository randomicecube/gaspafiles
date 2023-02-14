# overlays/discord.nix
#
# Enable OpenASAR for Discord

{ ... }:
final: prev: rec {
  discord-openasar = prev.discord.override { withOpenASAR = true; };
}

