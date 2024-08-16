{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./gaming.nix
    ./thunar.nix
  ];

  modules.gaming.enable = true; # TODO: Move module enables and options into one place so we can have multiple hosts

  environment.systemPackages = with pkgs; [
    config.nur.repos.nltch.spotify-adblock
    qbittorrent
    bitwarden
    firefox
    #(discord.override {
    # withVencord = true;
    #})
    vesktop
    pavucontrol
    aseprite
    sidequest
    prismlauncher
  ];
}
