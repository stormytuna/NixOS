{
  pkgs,
  inputs,
  ...
}: {
  programs.spicetify = let
    spicetifyPkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;

    enabledExtensions = with spicetifyPkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
  };
}
