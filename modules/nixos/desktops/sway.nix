{
  config,
  lib,
  ...
}: {
  options.modules.desktops.sway = {
    enable = lib.mkEnableOption "Tiling Wayland compositor";
  };

  config = lib.mkIf config.modules.desktops.sway.enable {
    security.polkit.enable = true; # Required to use Sway with home-manager
    programs.dconf.enable = true; # Required for GTK apps and configuration to work
  };
}
