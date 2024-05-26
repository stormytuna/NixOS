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
    gamescopeSession.enable = true;
  };

  # GPU drivers
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ amdvlk ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  };

  # GameMode, optimisations for games
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    vulkan-tools # For vkcube, useful debugging tool
  ];
}
