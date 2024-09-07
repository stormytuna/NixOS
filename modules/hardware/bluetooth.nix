{
  config,
  lib,
  ...
}: {
  options = {
    modules.hardware.bluetooth.enable = lib.mkEnableOption "Enables bluetooth capabilities and blueman applet";
  };

  config = lib.mkIf config.modules.hardware.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
