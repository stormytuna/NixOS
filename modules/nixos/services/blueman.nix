{
  config,
  lib,
  ...
}: {
  options.modules.services.blueman = {
    enable = lib.mkEnableOption "Bluetooth manager and GUI";
  };

  config = lib.mkIf config.modules.services.blueman.enable {
    services.blueman = {
      enable = true;
    };
  };
}
