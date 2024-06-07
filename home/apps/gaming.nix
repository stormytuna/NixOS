{ pkgs, userSettings, ... }:

{
  home.packages = with pkgs; [
    dxvk
    lutris
    heroic
    qbittorrent # Needed for pirating some stuff
  ];

  # MangoHud, toggleable resource display
  programs.mangohud.enable = true;
  home.file.".config/MangoHud/MangoHud.conf".source = ../config/MangoHud/MangoHud.conf;
}
