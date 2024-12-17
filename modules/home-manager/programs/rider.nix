{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.rider = {
    enable = lib.mkEnableOption "JetBrains' .NET IDE";
  };

  config = lib.mkIf config.modules.programs.rider.enable {
    home.packages = [pkgs.rider];

    home.file.".local/share/applications/jetbrains-rider.desktop".source = let
      desktopFile = pkgs.makeDesktopItem {
        name = "jetbrains-rider";
        desktopName = "Rider";
        exec = "\"${pkgs.rider}/bin/rider\"";
        icon = "rider";
        type = "Application";
        extraConfig.NoDisplay = "true";
      };
    in "${desktopFile}/share/applications/jetbrains-rider.desktop";
  };
}
