{ pkgs, ... }: {
  home.packages = [ pkgs.eww ];

  home.file.".config/eww/eww.yuck".source = ./eww.yuck;
  home.file.".config/eww/eww.scss".source = ./eww-dropdown.scss;

  # Scripts
  home.file.".local/bin/qs-eww-toggle" = {
    text = ''#!/usr/bin/env bash
# Robust eww toggle script
if ! eww ping >/dev/null 2>&1; then
  pkill -f "eww daemon" >/dev/null 2>&1 || true
  sleep 1
  eww daemon &
  sleep 1.5
fi
eww open --toggle quicksettings
'';
    executable = true;
  };

  home.file.".local/bin/qs-wifi-toggle" = {
    text = ''#!/usr/bin/env bash
                set -e
                if nmcli radio wifi | grep -qi enabled; then nmcli radio wifi off; else nmcli radio wifi on; fi
  '';
    executable = true;
  };
  home.file.".local/bin/qs-bt-toggle" = {
    text = ''#!/usr/bin/env bash
              set -e
              if bluetoothctl show | grep -q "Powered: yes"; then bluetoothctl power off; else bluetoothctl power on; fi
  '';
    executable = true;
  };

  home.file.".local/bin/qs-vpn-toggle" = {
    text = ''#!/usr/bin/env bash
              set -e
              if nmcli -t -f TYPE connection show --active | grep -q '^vpn$'; then
                nmcli -t -f NAME,TYPE connection show --active | awk -F: '$2=="vpn"{print $1}' | while read -r c; do
                  [ -n "$c" ] && nmcli connection down "$c"
                done
              else
                first=$(nmcli -t -f NAME,TYPE connection show | awk -F: '$2=="vpn"{print $1; exit}')
                [ -n "$first" ] && nmcli connection up "$first"
              fi
  '';
    executable = true;
  };

  home.file.".local/bin/qs-airplane-toggle" = {
    text = ''#!/usr/bin/env bash
            set -e
            if rfkill | awk '{print $4}' | grep -q yes; then rfkill unblock all; else rfkill block all; fi
            '';
    executable = true;
  };

  home.file.".local/bin/qs-brightness-set" = {
    text = ''#!/usr/bin/env bash
set -e
val="$1"
[ -n "$val" ] && brightnessctl set "$val%"
'';
    executable = true;
  };
}
