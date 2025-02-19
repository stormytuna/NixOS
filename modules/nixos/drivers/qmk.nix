{
  config,
  lib,
  pkgs,
  ...
}: {
  # TODO: Move somewhere else, just wanted to get it working
  options.modules.drivers.qmk = {
    enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.modules.drivers.qmk.enable {
    hardware.keyboard.qmk.enable = true;
    environment.systemPackages = [pkgs.qmk];
  };
}
