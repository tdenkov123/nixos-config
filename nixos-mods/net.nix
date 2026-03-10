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
  
  networking.nameservers = [ "83.220.169.155#dns.comss.one" ];
  # networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  services.resolved = {
    enable = true;
    dnsovertls = "true";
    llmnr = "true";
    # fallbackDns = [ "83.220.169.155#dns.comss.one" "212.109.195.93#dns.comss.one" ];
    fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
  };
}
