{
  config,
  lib,
  ...
}: {
  options.modules.desktops.cosmic = {
    enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.modules.desktops.cosmic.enable {
    services.desktopManager.cosmic.enable = true;
    services.desktopManager.cosmic-greeter.enable = true;
  };
}
