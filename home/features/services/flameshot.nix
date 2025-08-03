{
  config,
  pkgs,
  ...
}: {
  # Simple screenshotting tool
  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override {enableWlrSupport = true;};

    settings = let
      colours = config.lib.stylix.colors.withHashtag;
    in {
      General = {
        showStartupLaunchMessage = false;

        savePath = "/home/stormytuna/media/images/screenshots";
        saveAfterCopy = true;

        uiColor = colours.base0E;
        contrastUiColor = colours.base01;
      };
    };
  };
}
