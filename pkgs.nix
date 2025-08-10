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
    qbittorrent
    wireshark
    telegram-desktop
    mpv
    vesktop
    gparted
    obsidian
    nekoray

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
    python314
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
    
    # GUI utils
    feh
    imv
    udisks
    #mako

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
    polybar
    (unstablePkgs.waybar)
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
  
  services.udev.extraRules = ''
    KERNEL=="tun", NAME="net/%k", MODE="0666"
  '';
}
