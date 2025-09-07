{ pkgs, lib, ... }: {
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  programs.dconf.enable = true;

  services.gnome = {
    gnome-keyring.enable = true;
    glib-networking.enable = true;
  };

  programs.dconf.profiles.user.databases = [{
    settings = {
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" "xwayland-native-scaling" ];
        dynamic-workspaces = false;
        num-workspaces = lib.gvariant.mkUint32 4;
        workspaces-only-on-primary = true;
      };
      
      "org/gnome/desktop/interface" = {
        clock-show-seconds = true;
        clock-show-weekday = true;
        show-battery-percentage = true;
        color-scheme = "prefer-dark";
        gtk-theme = "Adwaita-dark";
        icon-theme = "Adwaita";
        text-scaling-factor = lib.gvariant.mkDouble 0.9;
      };

      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
      };

      "org/gnome/shell" = {
        enabled-extensions = [
          "blur-my-shell@aunetx"
          "appindicatorsupport@rgcjonas.gmail.com"
          "caffeine@patapon.info"
          "Vitals@CoreCoding.com"
        ];
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Files.desktop"
          "org.gnome.Terminal.desktop"
        ];
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        brightness = lib.gvariant.mkDouble 0.75;
        sigma = lib.gvariant.mkInt32 15;
      };
      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur = true;
        brightness = lib.gvariant.mkDouble 0.8;
        sigma = lib.gvariant.mkInt32 20;
      };
      "org/gnome/shell/extensions/blur-my-shell/overview" = {
        blur = true;
        brightness = lib.gvariant.mkDouble 0.8;
      };

      "org/gnome/shell/extensions/appindicator" = {
        icon-brightness = lib.gvariant.mkDouble 0.0;
        icon-contrast = lib.gvariant.mkDouble 0.0;
        icon-saturation = lib.gvariant.mkDouble 0.0;
        icon-size = lib.gvariant.mkInt32 20;
      };

      "org/gnome/shell/extensions/vitals" = {
        hot-sensors = [ "_processor_frequency_" "_processor_usage_" "_memory_usage_" "_temperature_max_" ];
        position-in-panel = lib.gvariant.mkInt32 2;
        icon-style = lib.gvariant.mkInt32 1;
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "close,minimize,maximize:appmenu";
      };
    };
  }];

  environment.systemPackages = with pkgs; [
    gnome-session
    gnome-shell
    gnome-tweaks
    gnome-extension-manager
    dconf-editor
    
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.vitals
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-maps
    gnome-contacts
    gnome-font-viewer
    gnome-music
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

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
}
