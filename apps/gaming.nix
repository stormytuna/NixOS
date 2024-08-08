{ config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      # Fixes gamescope not working with steam + undefined symbols in xwayland
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
        openxr-loader
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
      "--output-width 3840"
      "--output-height 2160"
      "--nested-width 3840"
      "--nested-height 2160"
      "--borderless"
      "--expose-wayland"
      "--force-grab-cursor"
      "--mangoapp" # Preferred to launching mangoscope itself
    ];
    package = pkgs.gamescope_git;
  };

  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  # VR
  services.monado = {
    enable = true;
    defaultRuntime = true;
  };
  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };

  environment.systemPackages = with pkgs; [
    lutris
    heroic
    wineWowPackages.stable
    winetricks
    mangohud
    vulkan-tools # For vkcube, useful debugging tool
    dxvk
  ];

  hardware.xpadneo.enable = true;
  programs.gamemode.enable = true;

  home-manager.users.stormytuna.home.file.".config/MangoHud/MangoHud.conf".source = ./conf/mangohud/mangohud.conf;
  home-manager.users.stormytuna.home.file."openxr/1/active_runtime.json".text = ''
    {
      "file_format_version": "1.0.0",
      "runtime": {
        "name": "Monado",
        "library_path": "${pkgs.monado}/lib/libopenxr_monado.so"
      }
    }
  '';
  home-manager.users.stormytuna.home.file."openvr/openvrpaths.vrpath".text = ''
    {
      "config": [ "/home/stormytuna/.steam/steam/config" ],
      "external_drivers": null,
      "jsonid": "vrpathreg",
      "log": [ "/home/stormytuna/.steam/steam/logs" ],
      "runtime": [ "${pkgs.opencomposite}/lib/opencomposite" ],
      "version": 1
    }
  '';
}
