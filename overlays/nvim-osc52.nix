#overlays/nvim-osc52.nix
#
# Have access to nvim-osc52 (clipboard stuff)

{ inputs, ... }:
final: prev: rec {
  nvim-osc52 = final.vimUtils.buildVimPlugin {
    name = "nvim-osc52";
    src = inputs.nvim-osc52;
  };
}