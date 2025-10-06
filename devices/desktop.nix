{ config, pkgs, ... }: {
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "schedutil";
  services.power-profiles-daemon.enable = true;

  services.fstrim.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
