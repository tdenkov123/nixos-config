{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "pidof hyprlock || hyprlock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 180;
          on-timeout = "brightnessctl -s set 30";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 30000;
          on-timeout = "pidof hyprlock || hyprlock";
        }
        {
          timeout = 60000;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 120000;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
