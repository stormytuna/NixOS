{
  config,
  pkgs,
  ...
}: {
  # Simple screenshotting tool
  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.overrideAttrs {enableWlrSupport = true;};

    settings = let
      colours = config.lib.stylix.colors.withHashtag;
    in {
      General = {
        showStartupLaunchMessage = false;

        saveAfterCopy = true;

        uiColor = colours.base0E;
        contrastUiColor = colours.base01;
      };
    };
  };
}
