{ pkgs, userSettings, ... }:

{
  fonts = {
    fontDir.enable = true; # Makes symlinks for fonts

    packages = with pkgs; userSettings.fontPackages ++ [
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
      serif = userSettings.serifFonts;
      sansSerif = userSettings.sansSerifFonts;
      monospace = userSettings.monospaceFonts;
    };
  };
}
