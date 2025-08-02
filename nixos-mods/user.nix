{ pkgs, ...}: {
  programs.zsh.enable = true;
  
  users = {
    defaultUserShell = pkgs.zsh;
    users.tdenkov = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "input" ];
    };
  };

}
