{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.spotify;
in {
  options.modules.programs.spotify = {
    enable = lib.mkEnableOption "Audio streaming service";
    enableAdblock = lib.mkEnableOption "Use spotify-adblock package";
  };

  config = lib.mkIf config.modules.programs.spotify.enable {
    home.packages = [
      (
        if cfg.enableAdblock
        then config.nur.repos.nltch.spotify-adblock
        else pkgs.spotify
      )
    ];

    # TODO: Any way to theme/configure spotify?
  };
}
