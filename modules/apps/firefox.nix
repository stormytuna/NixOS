{
  config,
  lib,
  pkgs,
  ...
}: let
  arcWtf = pkgs.fetchFromGitHub {
    owner = "KiKaraage";
    repo = "ArcWTF";
    rev = "v1.2-firefox";
    hash = "sha256-c1md5erWAqfmpizNz2TrM1QyUnnkbi47thDBMjHB4H0=";
  };
in {
  imports = [<home-manager/nixos>];

  options = {
    modules.apps.firefox.enable = lib.mkEnableOption "Enables firefox browser and configuration";
  };

  # TODO: Config for if we want to enable arc theme
  config = lib.mkIf config.modules.apps.firefox.enable {
    home-manager.users.stormytuna = {
      programs.firefox = {
        enable = true;
        profiles.default = {
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "svg.context-properties.content.enabled" = true;
            "uc.tweak.popup-search" = true;
            "uc.tweak.hide-sidebar-header" = true;
            "uc.tweak.longer-sidebar" = true;
          };
          isDefault = true;
        };
      };

      home.file.".mozilla/firefox/default/chrome" = {
        source = arcWtf;
        recursive = true;
      };
    };
  };
}
