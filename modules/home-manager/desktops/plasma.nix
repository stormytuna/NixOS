{
  config,
  lib,
  ...
}: {
  options.modules.desktops.plasma = {
    enable = lib.mkEnableOption "Wayland desktop environment";
  };

  config = lib.mkIf config.modules.desktops.plasma.enable {
    # TODO: Configure with plasma-manager
  };
}
