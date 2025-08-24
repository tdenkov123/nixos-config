{ pkgs, ... }: {
  home.packages = [ pkgs.eww ];

  home.file.".config/eww/eww.yuck".text = ''
;; Eww Quick Settings
(defpoll wifi_status :interval "5s" "nmcli radio wifi")
(defpoll bt_status   :interval "5s" "bluetoothctl show | awk '/Powered:/ {print $2}'")
(defpoll vpn_status  :interval "5s" "bash -c 'if nmcli -t -f TYPE connection show --active | grep -q ^vpn$; then echo on; else echo off; fi'")
(defpoll volume      :interval "2s" "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}'")
(defpoll brightness  :interval "3s" "bash -c 'b=$(brightnessctl g); m=$(brightnessctl m); echo $((100*b/m))'")

(defwindow quicksettings
  :monitor 0
  :geometry (geometry :x "-12" :y "40" :width 340 :height 400 :anchor "top right")
  :stacking "fg"
  :exclusive false
  (box :class "qs-root" :orientation "vertical" :spacing 14 :padding 14
    (box :class "qs-header" :spacing 8
      (label :class "qs-title" :text "Quick Settings")
      (button :class "qs-close" :onclick "eww close quicksettings" "󰅖"))

    (box :class "qs-toggles" :spacing 8
      (button :class "qs-toggle" :onclick "~/.local/bin/qs-wifi-toggle" (label :text "Wi-Fi: ") (label :text wifi_status))
      (button :class "qs-toggle" :onclick "~/.local/bin/qs-bt-toggle" (label :text "BT: ") (label :text bt_status))
      (button :class "qs-toggle" :onclick "~/.local/bin/qs-vpn-toggle" (label :text "VPN: ") (label :text vpn_status))
      (button :class "qs-toggle" :onclick "~/.local/bin/qs-airplane-toggle" "Airplane"))

    (box :class "qs-sliders" :orientation "vertical" :spacing 10
      (box :spacing 6 (label :text "Volume") (scale :class "qs-scale" :orientation "horizontal" :min 0 :max 100 :value volume :onchange "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ {}%"))
      (box :spacing 6 (label :text "Brightness") (scale :class "qs-scale" :orientation "horizontal" :min 0 :max 100 :value brightness :onchange "~/.local/bin/qs-brightness-set {}")))

    (box :class "qs-footer" :spacing 10
      (button :class "qs-footer-btn" :onclick "swaync-client -t" "Notifications")
      (button :class "qs-footer-btn" :onclick "nm-connection-editor" "Networks")
      (button :class "qs-footer-btn" :onclick "pavucontrol" "Audio"))
  )
)
'';

  home.file.".config/eww/eww.scss".text = ''
$q-bg: #1d2021cc; // semi-transparent background
$q-border: #98971a;
$q-accent: #d65d0e;
$q-accent2: #458588;
$q-fg: #ebdbb2;
$q-fg-dim: #a89984;

.qs-root {
  background: $q-bg;
  border: 1px solid $q-border;
  border-radius: 18px;
  color: $q-fg;
  font-family: "JetBrains Mono", monospace;
}
.qs-title { font-weight: bold; font-size: 18px; }
.qs-close { background: transparent; color: $q-fg-dim; }
.qs-close:hover { color: $q-accent; }
.qs-toggles { flex-wrap: wrap; }
.qs-toggle { background: #282828; padding: 6px 10px; border-radius: 10px; }
.qs-toggle:hover { background: $q-accent2; }
.qs-scale slider { min-width: 180px; }
.qs-footer { margin-top: 6px; }
.qs-footer-btn { background: #282828; padding: 6px 10px; border-radius: 10px; }
.qs-footer-btn:hover { background: $q-accent; }
'';

  # Scripts
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
val=${1%%%}
[ -n "$val" ] && brightnessctl set "${val}%"
'';
    executable = true;
  };
}
