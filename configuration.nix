{ inputs, hostName, homeStateVersion, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./nixos-mods/global.nix
    ./pkgs.nix
  ];

  networking.hostName = hostName;

  time.timeZone = "Europe/Moscow";
 
  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHOME = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };  

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  boot.loader.systemd-boot.configurationLimit = 5;

  system.stateVersion = homeStateVersion;
}
