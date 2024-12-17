{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.desktops.xfce = {
    enable = lib.mkEnableOption "Lightweight GTK-based desktop environment";
  };

  config = lib.mkIf config.modules.desktops.xfce.enable {
    services.xserver = {
      enable = true;
      desktopManager = {
        xfce.enable = true;
      };
    };

    environment.systemPackages = with pkgs.xfce; [
      catfish # File searching tool
      orage # Calendar
      xfce4-appfinder
      xfce4-clipman-plugin # Clipboard manager
      xfce4-cpugraph-plugin
      xfce4-fsguard-plugin # Filesystem usage monitor
      xfce4-genmon-plugin # Monitor manager
      xfce4-netload-plugin # Internet load speed
      xfce4-pulseaudio-plugin # Audio management
      xfce4-whiskermenu-plugin # App launcher
    ];

    programs.dconf.enable = true; # TODO: Maybe move elsewhere?
  };
}
