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
    throne
    thunderbird
    libreoffice
    feh
    imv
    udisks
  ];
}