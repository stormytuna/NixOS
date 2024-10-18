{
  config,
  lib,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./discord.nix
    ./firefox.nix
    ./gaming.nix
    ./minecraft-server.nix
    ./spotify.nix
    ./thunar.nix
    ./vesktop.nix
    ./zen.nix
  ];

  options = {
    modules.apps.enable = lib.mkEnableOption "Enables various applications that don't have their own module";
  };

  config = lib.mkIf config.modules.apps.enable {
    environment.systemPackages = with pkgs; [
      qbittorrent
      pkgs-stable.bitwarden # 2024/10/17 - Was blocking builds for some reason, didnt bother researching
      pavucontrol
      aseprite
      sidequest
      prismlauncher
    ];
  };
}
