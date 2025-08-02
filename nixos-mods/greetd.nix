{ pkgs, user, ... }: let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session} --asterisks --asterisks-char * --greet-align center --theme 000000 --theme-bg 282828 --theme-fg d4be98 --theme-input-fg d4be98 --theme-input-bg 3c3836 --theme-spinner d4be98";
        user = user;
      };
    };
  };
}
