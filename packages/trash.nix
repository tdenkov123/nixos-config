{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      papirus-nord
      
      pipewire
      pamixer

      grim
      grimblast

      home-manager
      papirus-nord
      polkit
      playerctl
  ];
}