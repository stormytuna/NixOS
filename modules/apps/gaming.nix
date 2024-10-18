{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [<home-manager/nixos>];

  options = {
    modules.apps.gaming.enable = lib.mkEnableOption "Enables gaming module";
  };

  config = lib.mkIf config.modules.apps.gaming.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        # Fixes gamescope not working with steam + undefined symbols in xwayland
        extraPkgs = pkgs:
          with pkgs; [
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
            openxr-loader
          ];
      };
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };

    programs.gamescope = {
      enable = true;
      args = [
        "--output-width 3840"
        "--output-height 2160"
        "--nested-width 3840"
        "--nested-height 2160"
        "--expose-wayland"
        "--force-grab-cursor"
      ];
      package = pkgs.gamescope_git;
    };

    environment.systemPackages = with pkgs; [
      lutris
      heroic
      wineWowPackages.stable
      winetricks
      mangohud
      vulkan-tools # For vkcube, useful debugging tool
      dxvk
      r2modman
    ];

    hardware.xpadneo.enable = true;
    programs.gamemode.enable = true;

    home-manager.users.stormytuna.home.file.".config/MangoHud/MangoHud.conf".source = ./conf/mangohud.conf;
  };
}
