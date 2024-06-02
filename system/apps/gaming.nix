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

  # Steam needs to be enabled at system level to enable gamescope
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
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
