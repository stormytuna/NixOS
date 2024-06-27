{ pkgs, ... }:

{
  # Fixes gamescope not working with steam + undefined symbols in xwayland
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.gamescope = {
    enable = true;
    args = [
      "--output-width 2560"
      "--output-height 1440"
      "--nested-width 2560"
      "--nested-height 1440"
      "--borderless"
      "--expose-wayland"
      "--force-grab-cursor"
      "--mangoapp" # Preferred to launching mangoscope itself
    ];
    package = pkgs.gamescope_git;
  };

  # XBox controller drivers
  hardware.xpadneo.enable = true;

  # GameMode, optimisations for games
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
    vulkan-tools # For vkcube, useful debugging tool
  ];
}
