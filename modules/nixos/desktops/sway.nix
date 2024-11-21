{
  config,
  lib,
  ...
}: {
  options.modules.desktops.sway = {
    enable = lib.mkEnableOption "Tiling Wayland compositor";
  };

  config = lib.mkIf config.modules.desktops.sway.enable {
    # Required to use Sway with home-manager
    security.polkit.enable = true;
  };
}
