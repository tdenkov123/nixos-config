{ config, user, ... }:
let

  accent = "#${config.lib.stylix.colors.base0D}";
  accent-alt = "#${config.lib.stylix.colors.base03}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  foreground = "#${config.lib.stylix.colors.base05}";
  foregroundOnWallpaper = "#${config.lib.stylix.colors.base05}";
  font = "${config.stylix.fonts.monospace.name}";
  fontSizeForHyprpanel = "${toString config.stylix.fonts.sizes.applications}px";

  rounding = 15;
  border-size = 5;
  gaps-out = 4;
  gaps-in = 4;

  floating = false;
  transparent = true;
  transparentButtons = false;
  position = "top";

  notificationOpacity = 90;

  location = "Europe/Moscow";
  homeDir = "/home/${user}";

in
{
  home.file.".config/hyprpanel/style.css".source = ./style.css;

  programs.hyprpanel = {
    enable = true;
    settings = {
      bar = {
        layouts = {
          "*" = {
            left = [ "workspaces" "windowtitle" ];
            middle = [ "media" "cava" ];
            right = [
              "systray"
              "volume"
              "bluetooth"
              "network"
              "clock"
              "notifications"
            ];
          };
        };

        launcher.icon = "";
        workspaces.show_numbered = false;
        workspaces.workspaces = 5;
        workspaces.numbered_active_indicator = "color";
        workspaces.monitorSpecific = false;
        workspaces.applicationIconEmptyWorkspace = "";
        workspaces.showApplicationIcons = true;
        workspaces.showWsIcons = true;

        windowtitle.label = true;
        volume.label = false;
        network.truncation_size = 12;
        bluetooth.label = false;
        clock.format = "%a %b %d  %I:%M %p";
        notifications.show_total = true;
        media.show_active_only = true;
      };

      notifications.position = "top right";
      notifications.showActionsOnHover = true;

      menus.clock.weather.location = location;
      menus.clock.weather.unit = "metric";
      menus.dashboard.powermenu.confirmation = false;
      menus.dashboard.powermenu.avatar.image = "~/.face.icon";
      menus.power.lowBatteryNotification = true;

      wallpaper.enable = false;

      theme = {
        font.name = font;
        font.size = fontSizeForHyprpanel;

        bar = {
          floating = floating;
          background = background + (if transparentButtons && transparent then "00" else "");
          outer_spacing = if floating && transparent then "0px" else "8px";
          margin_top = (if position == "top" then toString (gaps-in * 2) else "0") + "px";
          margin_bottom = (if position == "top" then "0" else toString (gaps-in * 2)) + "px";
          margin_sides = toString gaps-out + "px";
          border_radius = toString rounding + "px";
          transparent = transparent;
          location = position;
          dropdownGap = "4.5em";

          customModules = {
            updates.pollingInterval = 1440000;
            cava = {
              showIcon = false;
              stereo = true;
              showActiveOnly = true;
            };
          };

          menus = {
            menu.media.background.color = background-alt;
            menu.media.card.color = background-alt;
            background = background;
            cards = background-alt;
            label = foreground;
            text = foreground;
            border.color = accent;
            popover.text = foreground;
            popover.background = background-alt;
            listitems.active = accent;
            icons.active = accent;
            switch.enabled = accent;
            check_radio_button.active = accent;
            buttons.default = accent;
            buttons.active = accent;
            iconbuttons.active = accent;
            progressbar.foreground = accent;
            slider.primary = accent;
            tooltip.background = background-alt;
            tooltip.text = foreground;
            dropdownmenu.background = background-alt;
            dropdownmenu.text = foreground;
            monochrome = true;
            card_radius = toString rounding + "px";
            border.size = toString border-size + "px";
            border.radius = toString rounding + "px";
            menu.media.card.tint = 90;
            shadow = if transparent then "0 0 0 0" else "0px 0px 3px 1px ${background}";
          };

          buttons = {
            style = "default";
            monochrome = true;
            icon = accent;
            hover = background;
            spacing = "0.3em";
            padding_x = "0.8rem";
            padding_y = "0.4rem";
            y_margins = if floating && transparent then "0px" else "8px";
            radius = (if transparent then toString rounding else toString (rounding - 8)) + "px";
            text = if transparent && transparentButtons then foregroundOnWallpaper else foreground;
            background = (if transparent then background else background-alt) + (if transparentButtons then "00" else "");

            workspaces = {
              hover = accent-alt;
              active = accent;
              available = accent-alt;
              occupied = accent-alt;
            };
            notifications = {
              background = background-alt;
              hover = background;
              total = accent;
              icon = accent;
            };
          };
        };

        osd = {
          enable = true;
          orientation = "vertical";
          location = "left";
          radius = toString rounding + "px";
          margins = "0px 0px 0px 10px";
          muted_zero = true;
          bar_color = accent;
          bar_overflow_color = accent-alt;
          icon = background;
          icon_container = accent;
          label = accent;
          bar_container = background-alt;
        };

        notification = {
          opacity = notificationOpacity;
          enableShadow = true;
          border_radius = toString rounding + "px";
          background = background-alt;
          actions.background = accent;
          actions.text = foreground;
          label = accent;
          border = background-alt;
          text = foreground;
          labelicon = accent;
          close_button.background = background-alt;
          close_button.label = "#${config.lib.stylix.colors.base08}";
        };
      };
    };
  };
}
