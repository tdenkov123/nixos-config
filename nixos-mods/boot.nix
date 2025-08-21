{ pkgs, lib, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  environment.systemPackages = [
    pkgs.efibootmgr
    pkgs.sbctl
  ];
}
