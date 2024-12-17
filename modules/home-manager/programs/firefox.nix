# TODO: Finish this
{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.firefox = {
    enable = lib.mkEnableOption "FOSS web browser";
    enableArcWtf = lib.mkEnableOption "Heavy modifications to Firefox to give an Arc-like experience";
  };

  config = lib.mkIf config.modules.programs.firefox.enable {
    programs.firefox = {
      enable = true;

      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          DisablePocket = true;
          DisableFirefoxScreenshots = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DontCheckDefaultBrowser = true;
          #ExtensionSettings = { }; # TODO: Declarative-ise extensions
        };
      };

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        settings = {
          # TODO: Declarative-ise other settings
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "uc.tweak.popup-search" = true;
          "uc.tweak.longer-sidebar" = true;
          "browser.startup.page" = 3;
          "browser.ctrlTab.sortByRecentlyUsed" = true;
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "widget.use-xdg-desktop-portal.mime-handler" = 1;
        };
      };
    };
  };
}
