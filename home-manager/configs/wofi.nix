{ config, ... }: {
  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      allow_images = true;
      width = 350;
      height = 450;
    };
  };

  home.file.".config/wofi/style.css".text = ''
    window {
      margin: 0px;
      border: 5px solid #${config.lib.stylix.colors.base0D};
      background-color: #${config.lib.stylix.colors.base00};
      border-radius: 15px;
      font-family: "${config.stylix.fonts.monospace.name}";
      font-size: ${toString config.stylix.fonts.sizes.applications}px;
    }

    #input {
      margin: 8px;
      border: 2px solid #${config.lib.stylix.colors.base03};
      color: #${config.lib.stylix.colors.base05};
      background-color: #${config.lib.stylix.colors.base01};
      border-radius: 8px;
      padding: 8px;
    }

    #inner-box {
      margin: 8px;
      border: none;
      background-color: #${config.lib.stylix.colors.base00};
    }

    #outer-box {
      margin: 8px;
      border: none;
      background-color: #${config.lib.stylix.colors.base00};
    }

    #scroll {
      margin: 0px;
      border: none;
    }

    #text {
      margin: 8px;
      border: none;
      color: #${config.lib.stylix.colors.base05};
    }

    #entry:selected {
      background-color: #${config.lib.stylix.colors.base03};
      color: #${config.lib.stylix.colors.base07};
      border-radius: 8px;
      border: 2px solid #${config.lib.stylix.colors.base0D};
    }
  '';
}