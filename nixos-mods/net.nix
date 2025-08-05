{ pkgs, ... }:  {
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
  
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
  
  boot.kernelModules = [ "tun" "tap" ];
  
  users.groups.vpn = {};
  
  security.wrappers.nekoray = {
    source = "${pkgs.nekoray}/bin/nekoray";
    capabilities = "cap_net_admin,cap_net_raw+eip";
    owner = "root";
    group = "root";
  };
}
