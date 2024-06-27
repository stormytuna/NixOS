{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    #spotify
    config.nur.repos.nltch.spotify-adblock
  ];
}
