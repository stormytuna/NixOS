{
  config,
  lib,
  ...
}: {
  options.modules.drivers.xpadneo = {
    enable = lib.mkEnableOption "Xbox One wireless controller drivers";
  };

  config = lib.mkIf config.modules.drivers.xpadneo.enable {
    hardware.xpadneo.enable = true;
  };
}
