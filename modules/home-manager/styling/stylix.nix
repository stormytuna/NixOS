{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.styling.stylix;
  colours = config.lib.stylix.colors.withHashtag;
in {
  options.modules.styling.stylix = {
    enable = lib.mkEnableOption "Global colours, fonts and wallpapers";

    base16Scheme = lib.mkOption {
      type = lib.types.str;
      description = "Base16 scheme to use for styling";
      example = "catppuccin-mocha";
    };

    wallpaperName = lib.mkOption {
      type = lib.types.str;
      description = "Wallpaper filename and extension to choose from ./wallpapers";
      example = "my-wallpaper.png";
      default = ./wallpapers/frieren-tree.png;
    };

    polarity = lib.mkOption {
      type = lib.types.str;
      description = "Polarity to path to Stylix, can be 'dark' or 'light'";
      example = "dark";
      default = "dark";
    };

    cursor = {
      package = lib.mkOption {
        description = "Cursor package";
        example = "pkgs.bibata-cursors";
        type = lib.types.package;
        default = pkgs.quintom-cursor-theme;
      };
      name = lib.mkOption {
        description = "Cursor name within package";
        example = "modern";
        type = lib.types.str;
        default = "Quintom_Ink";
      };
      size = lib.mkOption {
        description = "Cursor size";
        example = 32;
        type = lib.types.int;
      };
    };

    icons = {
      package = lib.mkOption {
        description = "GTK icon package";
        example = "pkgs.candy-icons";
        type = lib.types.package;
      };
      name = lib.mkOption {
        description = "GTK icon name";
        example = "candy-icons";
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf config.modules.styling.stylix.enable {
    gtk.iconTheme = cfg.icons;

    stylix = {
      enable = true;
      autoEnable = true;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.base16Scheme}.yaml";

      image = ./wallpapers/${cfg.wallpaperName};

      polarity = cfg.polarity;

      cursor = cfg.cursor;

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

    stylix.targets.hyprland.enable = false; # Stylix keeps trying to set a nonexistent field
  };
}
