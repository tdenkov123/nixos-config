{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["custom/media-player" "hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = [ "tray" "custom/vitals" "hyprland/language" "custom/weather" "pulseaudio" "battery" "clock" ];
        "hyprland/workspaces" = {
          disable-scroll = true;
          show-special = true;
          special-visible-only = true;
          all-outputs = false;
          format = "{}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "magic" = "M";
          };

          persistent-workspaces = {
            "*" = 8;
          };
        };

        "hyprland/language" = {
          format = "{}";
          format-en = "en";
          on-click = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
          format-ru = "ru";
        };

        "custom/weather" = {
          format = " {} ";
          exec = "curl -s 'wttr.in/Moscow?format=%c%t'";
          interval = 300;
          class = "weather";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-muted = "";
          format-icons = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
          };
          on-click = "pavucontrol";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 1;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };

        "clock" = {
          format = "{:%d.%m.%Y - %H:%M}";
          format-alt = "{:%A, %B %d at %R}";
        };

        "tray" = {
          icon-size = 14;
          spacing = 1;
        };

        "custom/media-player" = {
          format = "{icon} {artist} - {title}";
          format-icons = {
            playing = "";
            paused = "";
            stopped = "";
          };
          exec = "python3 ${./scripts/media-player.py}";
          interval = 2;
          max-length = 50;
          on-click = "playerctl play-pause";
          on-scroll-up = "playerctl next";
          on-scroll-down = "playerctl previous";
        };

        "custom/vitals" = {
          format = "CPU: {cpu}% | RAM: {ram}% | TEMP: {temp}°C";
          exec = "python3 ${./scripts/vitals.py}";
          interval = 3;
          tooltip = true;
          on-click = "gnome-system-monitor";
        };
      };
    };
  };
}