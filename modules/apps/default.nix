{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./discord.nix
    ./firefox.nix
    ./gaming.nix
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
      bitwarden
      pavucontrol
      aseprite
      sidequest
      prismlauncher
    ];
  };
}
