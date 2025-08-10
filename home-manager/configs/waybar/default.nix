{ pkgs, unstablePkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = unstablePkgs.waybar;
    style = ./style.css;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["hyprland/workspaces" "cpu" "custom/cpu-freq" "memory"];
        modules-center = ["group/mpris" "hyprland/window"];
        modules-right = [ "tray" "hyprland/language" "custom/weather"  "pulseaudio" "battery" "clock" ];
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

        "cpu" = {
          format = " {usage}%";
          interval = 5;
          tooltip = true;
        };

        "memory" = {
          format = " {percentage}%";
          interval = 5;
          tooltip = true;
        };

        "custom/cpu-freq" = {
          format = "󰻠 {}";
          exec = "awk -F: '/cpu MHz/ {sum+=$2; n++} END { if (n) printf(\"%.1f GHz\", sum/n/1000) }' /proc/cpuinfo";
          interval = 3;
          tooltip = false;
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
          scroll-step = 2;
          on-click = "pavucontrol";
          on-scroll-up = "pamixer -i 2";
          on-scroll-down = "pamixer -d 2";
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

        "group/mpris" = {
          orientation = "horizontal";
          modules = ["image#mpris-art" "custom#mpris-text" "custom#mpris-prev" "custom#mpris-toggle" "custom#mpris-next"];
        };

        "image#mpris-art" = {
          exec = "bash ${./scripts/mpris_art.sh} 26";
          size = 26;
          interval = 2;
        };

        "custom#mpris-text" = {
          return-type = "json";
          exec = "bash ${./scripts/mpris_block.sh}";
          format = "{text}";
          tooltip = true;
          escape = false;
          hide-empty-text = true;
          on-click = "playerctl -p spotify play-pause";
        };

        "custom#mpris-prev" = {
          exec = "echo ''";
          exec-if = "playerctl -p spotify status >/dev/null 2>&1";
          interval = 3600;
          tooltip = false;
          on-click = "playerctl -p spotify previous";
        };
        "custom#mpris-toggle" = {
          exec = "playerctl -p spotify status 2>/dev/null | awk '{ if ($1==\"Playing\") print \"\"; else print \"\" }'";
          exec-if = "playerctl -p spotify status >/dev/null 2>&1";
          interval = 1;
          tooltip = false;
          on-click = "playerctl -p spotify play-pause";
        };
        "custom#mpris-next" = {
          exec = "echo ''";
          exec-if = "playerctl -p spotify status >/dev/null 2>&1";
          interval = 3600;
          tooltip = false;
          on-click = "playerctl -p spotify next";
        };
      };
    };
  };

  systemd.user.services.waybar = {
    Unit = {
      After = [ "graphical-session.target" "pipewire.socket" "pipewire-pulse.socket" "wireplumber.service" ];
      Wants = [ "pipewire.socket" "pipewire-pulse.socket" "wireplumber.service" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStartPre = [ "${pkgs.pulseaudio}/bin/pactl info >/dev/null 2>&1 || true" ];
    };
  };
}