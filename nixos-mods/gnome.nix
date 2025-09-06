{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
  };
  
  services.xserver.displayManager.gdm.enable = false;

  services.gnome = {
    gnome-keyring.enable = true;
    glib-networking.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    dconf-editor
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    cheese
    gnome-terminal
    epiphany
    geary
    evince
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
  ]);

  # services.xserver.displayManager.gdm.autoSuspend = false;
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "tdenkov";

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
}
