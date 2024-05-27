{ pkgs, userSettings, ... }:

{
  fonts = {
    fontDir.enable = true; # Makes symlinks for fonts

    packages = with pkgs; userSettings.extraFontPackages ++ [
      (nerdfonts.override { 
        fonts = [
          "Hack"
          "JetBrainsMono"
        ];
      })

      iosevka
      font-awesome
      terminus_font
    ];

    fontconfig.defaultFonts = {
      serif = [ userSettings.fonts.serif.name] ;
      sansSerif = [ userSettings.fonts.sansSerif.name ];
      monospace = [ userSettings.fonts.monospace.name ];
      emoji = [ userSettings.fonts.emoji.name ];
    };
  };
}
