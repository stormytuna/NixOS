{
  pkgs,
  config,
  ...
}: let
  colours = config.lib.stylix.colors.withHashtag;
in {
  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus";
  };

  stylix = {
    enable = true;
    autoEnable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-ocean.yaml";

    image = ./wallpapers/miku-sky.jpg;

    polarity = "dark";

    cursor = {
      package = pkgs.quintom-cursor-theme;
      name = "Quintom_Ink";
      size = 24;
    };

    fonts = {
      # Font faces
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      monospace = {
        name = "Hasklug Nerd Font";
        package = pkgs.nerd-fonts.hasklug;
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };

      # Font sizes
      sizes = {
        applications = 14;
        desktop = 10;
        popups = 10;
        terminal = 16;
      };
    };

    opacity.terminal = 0.9;
  };

  # Application specific config
  # Waybar
  # TODO: optional
  stylix.targets.waybar.enable = false; # Stylix has awful waybar styles by default
  home.file.".config/waybar/colors.css".text = ''
    @define-color base00 ${colours.base00};
    @define-color base01 ${colours.base01};
    @define-color base02 ${colours.base02};
    @define-color base03 ${colours.base03};
    @define-color base04 ${colours.base04};
    @define-color base05 ${colours.base05};
    @define-color base06 ${colours.base06};
    @define-color base07 ${colours.base07};
    @define-color base08 ${colours.base08};
    @define-color base09 ${colours.base09};
    @define-color base0A ${colours.base0A};
    @define-color base0B ${colours.base0B};
    @define-color base0C ${colours.base0C};
    @define-color base0D ${colours.base0D};
    @define-color base0E ${colours.base0E};
    @define-color base0F ${colours.base0F};
  '';

  stylix.targets.mangohud.enable = false; # Stylix defaults clash with custom config
}
