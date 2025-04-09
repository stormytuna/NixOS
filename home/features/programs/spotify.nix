{pkgs, ...}: {
  # TODO: any way to theme it?
  home.packages = [
    pkgs.nur.repos.nltch.spotify-adblock
  ];
}
