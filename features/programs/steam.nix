{pkgs, inputs, ...}: {
  programs.steam =
  let
    millenniumPackage = inputs.millennium.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in
  {
    enable = true;
    package = millenniumPackage;
    protontricks.enable = true;

    # todo: unsure if override is still necessary
    # Allow gamescope to work in steam
    #package = pkgs.steam.override {
    #  extraPkgs = pkgs:
    #    with pkgs; [
    #      libxcursor
    #      libxi
    #      libxinerama
    #      libxscrnsaver
    #      libpng
    #      libpulseaudio
    #      libvorbis
    #      stdenv.cc.cc.lib
    #      libkrb5
    #      keyutils
    #      gamescope # TODO: Optional?
    #    ];
    #};

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    # allow online play
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
