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
  
  services.resolved.enable = true;
  services.resolved.fallbackDns = [ "8.8.8.8" "1.1.1.1" ];

  services.zapret = let
    zapretListUltimate = ./zapret/lists/list-ultimate.txt;
    zapretDiscordIpset = ./zapret/lists/ipset-discord.txt;
  in {
    enable = true;
    params = [
      # --filter-udp=443 --hostlist="%LIST_PATH%" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new
      "--filter-udp=443"
      "--hostlist=${zapretListUltimate}"
      "--dpi-desync=fake"
      "--dpi-desync-repeats=6"
      # If you have a QUIC initial packet blob for Linux, provide its path and uncomment the next line
      # "--dpi-desync-fake-quic=/path/to/quic_initial_www_google_com.bin"
      "--new"

      # --filter-udp=50000-65535 --ipset="%DISCORD_IPSET_PATH%" --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new
      "--filter-udp=50000-65535"
      "--ipset=${zapretDiscordIpset}"
      "--dpi-desync=fake"
      "--dpi-desync-any-protocol"
      "--dpi-desync-cutoff=d3"
      "--dpi-desync-repeats=6"
      "--new"

      # --filter-tcp=80 --hostlist="%LIST_PATH%" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new
      "--filter-tcp=80"
      "--hostlist=${zapretListUltimate}"
      "--dpi-desync=fake,split2"
      "--dpi-desync-autottl=2"
      "--dpi-desync-fooling=md5sig"
      "--new"

      # --filter-tcp=443 --hostlist="%LIST_PATH%" --dpi-desync=split --dpi-desync-split-pos=1 --dpi-desync-autottl --dpi-desync-fooling=badseq --dpi-desync-repeats=8
      "--filter-tcp=443"
      "--hostlist=${zapretListUltimate}"
      "--dpi-desync=split"
      "--dpi-desync-split-pos=1"
      "--dpi-desync-autottl"
      "--dpi-desync-fooling=badseq"
      "--dpi-desync-repeats=8"
    ];
    configureFirewall = true;
    httpSupport = true;
    httpMode = "first";
    udpSupport = true;
    udpPorts = [ "443" "50000:65535" ];
  };

  networking.nftables.enable = false;
}
