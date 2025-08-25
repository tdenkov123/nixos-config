{ config, pkgs, lib, homeStateVersion, user, ... }: {
  imports = [
    ./configs/default.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };
}
