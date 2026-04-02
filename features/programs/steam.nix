{pkgs, ...}: {
  programs.steam = {
    enable = true;
    protontricks.enable = true;

    # Allow gamescope to work in steam
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          libxcursor
          libxi
          libxinerama
          libxscrnsaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          gamescope # TODO: Optional?
        ];
    };

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    # Allow online play
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
