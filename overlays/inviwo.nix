# overlays/inviwo.nix
#
# Author: Joao Borges <RageKnify@gmail.com>
# URL:    https://github.com/RageKnify/Config
#
# Have access to inviwo

{ ... }:
final: prev: rec {
  inviwo = prev.libsForQt5.callPackage ({ lib, wrapQtAppsHook, qtbase, cmake
    , python3, freeglut, gcc8, pkg-config, libtirpc, rpcsvc-proto, brotli, xorg
    , mesa, libGLU, minizip, bzip2, harfbuzz, mkDerivation }:
    mkDerivation rec {
      name = "inviwo";
      version = "v0.9.11";

      src = prev.fetchFromGitHub {
        owner = "inviwo";
        repo = "inviwo";
        rev = "be889cc7aa7e2eafa30eec8fe56911a2bbcf944a";
        sha256 = "sha256-T8aErVxWpq4+HA/lkvfzBxQ7d5QDATV0kQk1e4zfWj4=";
      };

      buildInputs = [
        python3
        freeglut
        cmake
        gcc8
        pkg-config
        libtirpc
        rpcsvc-proto
        brotli
        xorg.libX11.dev
        xorg.libXrandr
        xorg.libXinerama
        xorg.libXcursor
        xorg.libXi
        mesa
        libGLU
        minizip
        bzip2
        harfbuzz
        qtbase
      ];
      nativeBuildInputs = [ cmake wrapQtAppsHook ];

      meta = {
        description = "inviwo, ...";
        homepage = "https://gits-15.sys.kth.se/Vis2023/dgaspar-inviwo";
        platforms = prev.lib.platforms.linux;
      };
    }) { };
}
