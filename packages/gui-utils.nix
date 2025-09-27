{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
    audacity
    chromium
    spotify spotifywm
    qbittorrent
    wireshark
    telegram-desktop
    mpv
    discord
    gparted
    obsidian
    nekoray
    thunderbird
    libreoffice
    feh
    imv
    udisks
  ];
}