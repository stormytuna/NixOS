{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.desktops.sway = {
    enable = lib.mkEnableOption "Tiling Wayland compositor";
  };

  config = lib.mkIf config.modules.desktops.sway.enable {
    wayland.windowManager.sway = {
      enable = true;
      xwayland = true;
      wrapperFeatures.gtk = true; # Fix issues with GTK 3 apps

      config = {
        modifier = "Mod4";
        terminal = "alacritty"; # TODO: configure
        startup = [
          {command = "steam -silent";}
        ];
      };
    };
  };
}
