{
  config,
  lib,
  pkgs,
  zen-browser,
  ...
}: {
  imports = [<home-manager/nixos>];

  options = {
    modules.apps.zen.enable = lib.mkEnableOption "Enables zen browser and configuration";
  };

  config = lib.mkIf config.modules.apps.zen.enable {
    environment.systemPackages = [zen-browser.packages."${pkgs.system}".default];

    environment.sessionVariables.DEFAULT_BROWSER = "${zen-browser.packages."${pkgs.system}".default}/bin/zen";

    xdg.mime.defaultApplications = {
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
    };

    # Creating own desktop file for "firefox" alias
    home-manager.users.stormytuna.xdg.desktopEntries.zen = {
      name = "Zen";
      exec = "zen %u";
      icon = "zen";
      type = "Application";
      mimeType = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "application/x-xpinstall"
        "application/pdf"
        "application/json"
      ];
      settings = {
        Categories = "Network;WebBrowser;";
        Keywords = "Internet;WWW;Browser;Web;Explorer;Firefox;";
      };
    };
  };
}
