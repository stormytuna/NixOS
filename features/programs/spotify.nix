{
  pkgs,
  inputs,
  ...
}: {
  programs.spicetify = let
    spicetifyPkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;

    enabledExtensions = with spicetifyPkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    enabledCustomApps = with spicetifyPkgs.apps; [
      lyricsPlus
    ];
  };
}
