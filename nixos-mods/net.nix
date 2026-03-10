{ pkgs, ... }:  {
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
  
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
  
  boot.kernelModules = [ "tun" "tap" ];
  
  users.groups.vpn = {};
  
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  services.resolved = {
    enable = true;
    dnsovertls = "true";
    llmnr = "true";
    fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
  };
}
