{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./discord.nix
    ./gaming.nix
    ./spotify.nix
    ./thunar.nix
  ];

  options = {
    modules.apps.enable = lib.mkEnableOption "Enables various applications that don't have their own module";
  };

  config = lib.mkIf config.modules.apps.enable {
    environment.systemPackages = with pkgs; [
      qbittorrent
      bitwarden
      firefox
      pavucontrol
      aseprite
      sidequest
      prismlauncher
    ];
  };
}
