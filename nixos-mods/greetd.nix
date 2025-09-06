{ pkgs, user, ... }: let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
  gnome-session = "${pkgs.gnome.gnome-session}/share/wayland-sessions:${pkgs.gnome.gnome-session}/share/xsessions";
  all-sessions = "${hyprland-session}:${gnome-session}";
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --sessions ${all-sessions} --greet-align center";
        user = user;
      };
    };
  };
}
