{ pkgs, ... }: {
  users.users.tpws = {
    isSystemUser = true;
    group = "tpws";
  };

  users.groups.tpws = {};
  
  services.zapret = {
    enable = true;
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
  
    path = with pkgs; [
      iptables
      nftables
      gawk
    ];
  
    serviceConfig = {
      Type = "forking";
      Restart = "no";
      TimeoutSec = "30sec";
      IgnoreSIGPIPE = "no";
      KillMode = "none";
      GuessMainPID = "no";
      ExecStart = "${pkgs.zapret}/bin/zapret start";
      ExecStop = "${pkgs.zapret}/bin/zapret stop";
    
      EnvironmentFile = pkgs.writeText "zapret-environment" ''
        MODE="tpws"
	ipv4 discord.com curl_test_http : working without bypass
        ipv4 discord.com curl_test_https_tls12 : tpws --split-tls=sni --oob
        ipv4 discord.com curl_test_https_tls12 : nfqws --dpi-desync=fake --dpi-desync-ttl=9
        ipv4 discord.com curl_test_https_tls13 : tpws --split-tls=sni --oob
        ipv4 discord.com curl_test_https_tls13 : nfqws --dpi-desync=fake --dpi-desync-ttl=10
      '';
    };
  };
}