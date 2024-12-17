{
  config,
  lib,
  ...
}: {
  options.modules.programs.adb = {
    enable = lib.mkEnableOption "Android Debug Bridge, CLI program for interfacing with android devices";
  };

  config = lib.mkIf config.modules.programs.adb.enable {
    programs.adb.enable = true;
  };
}
