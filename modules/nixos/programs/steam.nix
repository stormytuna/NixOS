{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.steam = {
    enable = lib.mkEnableOption "Game storefront and client";
  };

  config = lib.mkIf config.modules.programs.steam.enable {
    programs.steam = {
      enable = true;

      # Allow online play
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;

      extraCompatPackages = [pkgs.proton-ge-bin];
    };
  };
}
