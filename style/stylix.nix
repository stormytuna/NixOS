{ config, lib, pkgs, userSettings, ... }:

  let
    colourScheme = lib.fileContents ../style/current/colourscheme;

    wallpaperPath = ./. + "/wallpapers/${lib.fileContents ../style/current/wallpaper}.png"; 

    icons = lib.fileContents ../style/current/icons;
    iconStrings = lib.strings.splitString " " icons;
    iconPackageName = builtins.elemAt iconStrings 0;
    iconName = builtins.elemAt iconStrings 1;

    colours = config.lib.stylix.colors.withHashtag;
  in
{
  imports = [ <home-manager/nixos> ];

  stylix.enable = true;

  # TODO: Post-update scripts for refreshing themes everywhere

  stylix.polarity = lib.fileContents ../style/current/polarity;
  stylix.image = wallpaperPath;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${colourScheme}.yaml";
  stylix.fonts = userSettings.fonts;
  stylix.cursor = userSettings.cursorSettings;

  home-manager.users.stormytuna = { ... }:
  {
    gtk.iconTheme = {
      package = pkgs.${iconPackageName};
      name = iconName;
    };

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
    stylix.targets.alacritty.enable = false;

    # Linking wallpaper, stylix can't set hyprland wallpaper
    home.file.".config/hypr/wallpaper.png".source = wallpaperPath;
  };
}
