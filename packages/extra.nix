{
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  };

  programs.nekoray.tunMode.enable = true;

  services.udev.extraRules = ''
    KERNEL=="tun", NAME="net/%k", MODE="0666"
  '';
}