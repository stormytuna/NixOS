{ config, pkgs, userSettings, ... }:

  let
    colourScheme = config.lib.stylix.colors.withHashtag;
    wallpaperPath = ./. + "/wallpapers/${userSettings.wallpaper}.png"; 
  in
{
  imports = [ <home-manager/nixos> ];

  stylix.enable = true;

  # TODO: Post-update scripts for refreshing themes everywhere

  stylix.polarity = userSettings.polarity;
  stylix.image = wallpaperPath;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${userSettings.colourScheme}.yaml";
  stylix.fonts = userSettings.fonts;
  stylix.cursor = userSettings.cursorSettings;

  #gtk.iconTheme = userSettings.iconSettings; # home-manager option, should be unneeded

  home-manager.users.stormytuna = { ... }:
  {
    stylix.targets.waybar.enable = false; # Stylix has awful waybar styles by default
      home.file.".config/waybar/colors.css".text = ''
      @define-color base00 ${colourScheme.base00};
      @define-color base01 ${colourScheme.base01};
      @define-color base02 ${colourScheme.base02};
      @define-color base03 ${colourScheme.base03};
      @define-color base04 ${colourScheme.base04};
      @define-color base05 ${colourScheme.base05};
      @define-color base06 ${colourScheme.base06};
      @define-color base07 ${colourScheme.base07};
      @define-color base08 ${colourScheme.base08};
      @define-color base09 ${colourScheme.base09};
      @define-color base0A ${colourScheme.base0A};
      @define-color base0B ${colourScheme.base0B};
      @define-color base0C ${colourScheme.base0C};
      @define-color base0D ${colourScheme.base0D};
      @define-color base0E ${colourScheme.base0E};
      @define-color base0F ${colourScheme.base0F};
    '';

    stylix.targets.mangohud.enable = false;
    stylix.targets.alacritty.enable = false;

    # Linking wallpaper, stylix can't set hyprland wallpaper
    home.file.".config/hypr/wallpaper.png".source = wallpaperPath;
  };
}
