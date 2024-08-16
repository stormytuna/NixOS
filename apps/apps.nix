{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./gaming.nix
    ./thunar.nix
  ];

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
