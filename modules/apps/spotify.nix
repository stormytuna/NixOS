{
  config,
  lib,
  ...
}: {
  # TODO: Figure out how to theme spotify
  options = {
    modules.apps.spotify.enable = lib.mkEnableOption "Enables spotify";
  };

  config = lib.mkIf config.modules.apps.spotify.enable {
    environment.systemPackages = [
      config.nur.repos.nltch.spotify-adblock
    ];
  };
}
