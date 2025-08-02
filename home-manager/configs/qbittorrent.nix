{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    qbittorrent
  ];
  
  home.file.".local/share/qBittorrent/themes/catppuccin-macchiato.qbtheme".source = ../themes/catppuccin-macchiato.qbtheme;
  home.file.".local/share/qBittorrent/themes/catppuccin-mocha.qbtheme".source = ../themes/catppuccin-mocha.qbtheme;
}
