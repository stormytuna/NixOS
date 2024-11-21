{
  config,
  lib,
  ...
}: {
  options.modules.desktops.plasma = {
    enable = lib.mkEnableOption "Wayland desktop environment";
  };

  config = lib.mkIf config.modules.desktops.plasma.enable {
    services.xserver.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    services.desktopManager.plasma6.enable = true;
    services.displayManager.defaultSession = "plasma"; # Enables Wayland
  };
}
