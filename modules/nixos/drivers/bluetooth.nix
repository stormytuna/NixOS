{
  config,
  lib,
  ...
}: {
  options.modules.drivers.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth capabilities";
  };

  config = lib.mkIf config.modules.drivers.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
  };
}
