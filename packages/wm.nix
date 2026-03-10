{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
    swaynotificationcenter
  ];
}