# hosts/sly/home.nix
#
# Home configuration for sly (desktop).

{ pkgs, ... }: {
  modules = {
    graphical.alacritty.enable = true;
    graphical.dev.enable = true;
    graphical.gtk.enable = true;
    graphical.i3.enable = true;
    graphical.polybar.enable = true;
    graphical.programs.enable = true;
    graphical.rofi.enable = true;
    graphical.spotify.enable = true;
    graphical.sxhkd.enable = true;
    graphical.zathura.enable = true;
    neovim.enable = true;
    personal.enable = true;
    shell = {
      git.enable = true;
    };
    xdg.enable = true;
    zsh.enable = true;
  };

  home.packages = with pkgs;
    [
      # Add packages here.
    ];

  home.stateVersion = "22.11";
}