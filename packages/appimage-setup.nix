{ pkgs, ... }: {
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    fuse
    fuse3
    libGL
    qt5.qtbase
    qt5.qtwayland
    xorg.libX11
    xorg.libxcb
    xorg.libXi
    xorg.libXrender
    xorg.libXext
    openssl
    zlib
    stdenv.cc.cc.lib
    glibc
    libxml2
    curl
    libuuid
    pcre
    pcre2
  ];

}