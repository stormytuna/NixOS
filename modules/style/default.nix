{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.stylix;
  colours = config.lib.stylix.colors.withHashtag;
in {
  imports = [<home-manager/nixos>];

  options = {
    modules.stylix.enable = lib.mkEnableOption "Enables stylix and confiuration";

    modules.stylix.theming.wallpaper = lib.mkOption {
      default = ./fallback-wallpaper.png;
      description = "Wallpaper path";
      type = lib.types.path;
    };
    modules.stylix.theming.scheme = lib.mkOption {
      default = "catppuccin-mocha";
      description = "Base16 schema";
      type = lib.types.str;
    };
    modules.stylix.theming.polarity = lib.mkOption {
      default = "dark";
      description = "Stylix polarity, either 'dark' or 'light'";
      type = lib.types.str;
    };

    modules.stylix.icons.package = lib.mkOption {
      description = "GTK icon package";
      type = lib.types.package;
    };
    modules.stylix.icons.name = lib.mkOption {
      description = "GTK icon name";
      type = lib.types.str;
    };

    modules.stylix.fonts = lib.mkOption {
      description = "Fonts";
      type = lib.types.attrs;
    };

    modules.stylix.cursor = lib.mkOption {
      description = "Cursor";
      type = lib.types.attrs;
    };
  };

  config = lib.mkIf cfg.enable {
    stylix.enable = true;

    stylix.polarity = cfg.theming.polarity;
    stylix.image = cfg.theming.wallpaper;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.theming.scheme}.yaml";

    stylix.fonts = cfg.fonts;
    fonts.packages = [
      pkgs.noto-fonts
    ];

    stylix.cursor = cfg.cursor;

    home-manager.users.stormytuna = {...}: {
      gtk.iconTheme = cfg.icons;

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

      stylix.targets.mangohud.enable = false;

      # Linking wallpaper, stylix can't set hyprland wallpaper
      home.file.".config/hypr/wallpaper.png".source = cfg.theming.wallpaper;
    };
  };
}
