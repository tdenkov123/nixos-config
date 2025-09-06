{ pkgs, user, ... }: let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
  gnome-session = "${pkgs.gnome-session}/share/wayland-sessions:${pkgs.gnome-session}/share/xsessions";
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session} -xsessions ${gnome-session} --greet-align center --asterisks --asterisks-char *";
        user = user;
      };
    };
  };
}
