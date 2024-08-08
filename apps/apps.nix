{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    config.nur.repos.nltch.spotify-adblock
    qbittorrent
    btop
    bitwarden
    firefox
    (discord.override {
     withVencord = true;
    })
    vesktop
    pavucontrol
    aseprite
    sidequest
  ];
}
