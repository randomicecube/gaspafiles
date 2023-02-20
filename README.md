# gaspafiles

My Linux configurations, for machines running NixOS. Inspired by the work of:

- @RageKnify
- @diogotcorreia
- @luishfonseca
- @carjorvaz

Since I'm using flakes, the build process should be done via `nixos-rebuild switch --flake /path/to/flake.nix`.

**Relevant notes**:

- While cloning, use flags `-b <this branch>` and `--recursive`, in order to clone the submodules utilized in this repo.
- Upon building the system, remove the `~/.config/user-dirs.dirs` folder.
- Don't forget to copy the `hardware-configuration.nix` file to `hosts/<host>/hardware.nix`!

If anything goes wrong, it's always good to take a look at what happened through `journalctrl` - go to a TTY and run `journalctl -e`.

