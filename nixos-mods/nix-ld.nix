{ pkgs, ... }: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # GTK / desktop toolkit
    gtk3
    gtk2
    glib
    gdk-pixbuf
    cairo
    pango
    atk
    freetype
    fontconfig
    dbus
    nspr
    nss
    libnotify
    at-spi2-atk
    at-spi2-core
    # X11
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    xorg.libxshmfence
    # Graphics
    libGL
    libdrm
    mesa
    # Qt
    qt5.qtbase
    qt5.qtwayland
    # System
    fuse
    fuse3
    glibc
    openssl
    zlib
    curl
    libxml2
    libuuid
    pcre
    pcre2
    alsa-lib
    cups
    expat
    stdenv.cc.cc.lib
  ];
}