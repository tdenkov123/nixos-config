{ pkgs, lib, ... }: {
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
  };

  xdg.configFile."alacritty/alacritty.toml".source = lib.mkDefault ./alacritty.toml;
}
