{ pkgs, unstablePkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  };

  environment.systemPackages = with pkgs; [
    # Desktop
    audacity
    chromium
    spotify
    spotifywm
    qbittorrent
    wireshark
    telegram-desktop
    mpv
    discord
    gparted
    obsidian
    nekoray
    woeusb

    # Development
    gcc
    gnumake
    automake
    cmake
    ninja
    valgrind
    kdePackages.kcachegrind
    git-graph
    vscode
    sublime4
    neovim
    (python313.withPackages (ps: with ps; [ pip setuptools wheel pyqt5 ]))
    qt5.qtwayland
    qt5.qtbase
    qt5.qtdeclarative
    jupyter
    ripgrep
    silicon
    
    # CLI
    alacritty
    bottom
    kitty
    file
    fastfetch
    cpufetch
    inxi
    btop
    tree
    wget
    git
    htop
    curl
    zip
    unzip
    ffmpeg
    lux
    mediainfo
    bluez
    bluez-tools
    openssl
    brightnessctl
    yt-dlp
    eza
    mc
    yazi
    bat
    lazygit
    tetris
    efibootmgr
    os-prober
    mosquitto
    appimage-run
    
    # GUI utils
    feh
    imv
    udisks
    opcua-client-gui

    # Sound
    pipewire
    pulseaudio
    pamixer

    # GPU

    # Screenshots
    grim
    grimblast

    # Other
    home-manager
    papirus-nord
    polkit
    playerctl

    # Hyprland
    hyprland
    xwayland
    seatd
    xdg-desktop-portal-hyprland
    rofi-wayland
    wofi
    wl-clipboard
    cliphist
    hyprpicker
    pavucontrol
    xfce.thunar
    greetd.tuigreet
    swaynotificationcenter

  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.hurmit
  ];

  programs.nekoray.tunMode.enable = true;
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

  services.udev.extraRules = ''
    KERNEL=="tun", NAME="net/%k", MODE="0666"
  '';
}
