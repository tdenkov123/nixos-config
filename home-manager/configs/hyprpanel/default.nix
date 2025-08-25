{ pkgs, unstablePkgs, ... }: {
  programs.hyprpanel = {
    enable = true;
    package = unstablePkgs.hyprpanel;
    
    configFile = ./hyprpanel.conf;
    
    styleFile = ./style.css;
  };

  home.file.".local/bin/qs-toggle" = {
    text = ''#!/usr/bin/env bash
# Quick settings toggle script for hyprpanel
if [[ "$1" == "wifi" ]]; then
  if nmcli radio wifi | grep -qi enabled; then 
    nmcli radio wifi off
  else 
    nmcli radio wifi on
  fi
elif [[ "$1" == "bluetooth" ]]; then
  if bluetoothctl show | grep -q "Powered: yes"; then 
    bluetoothctl power off
  else 
    bluetoothctl power on
  fi
elif [[ "$1" == "vpn" ]]; then
  if nmcli -t -f TYPE connection show --active | grep -q '^vpn$'; then
    nmcli -t -f NAME,TYPE connection show --active | awk -F: '$2=="vpn"{print $1}' | while read -r c; do
      [ -n "$c" ] && nmcli connection down "$c"
    done
  else
    first=$(nmcli -t -f NAME,TYPE connection show | awk -F: '$2=="vpn"{print $1; exit}')
    [ -n "$first" ] && nmcli connection up "$first"
  fi
elif [[ "$1" == "airplane" ]]; then
  if rfkill | awk '{print $4}' | grep -q yes; then 
    rfkill unblock all
  else 
    rfkill block all
  fi
fi
'';
    executable = true;
  };

  home.file.".local/bin/brightness-set" = {
    text = ''#!/usr/bin/env bash
set -e
val="$1"
[ -n "$val" ] && brightnessctl set "$val%"
'';
    executable = true;
  };

  home.file.".local/bin/volume-set" = {
    text = ''#!/usr/bin/env bash
set -e
val="$1"
[ -n "$val" ] && wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "$val%"
'';
    executable = true;
  };
}
