{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.drivers.amd-graphics = {
    enable = lib.mkEnableOption "Various graphics settings for AMD GPUs";
  };

  config = lib.mkIf config.modules.drivers.amd-graphics.enable {
    # Video drivers
    services.xserver.videoDrivers = ["amdgpu"];

    # Graphics acceleration
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # *Actual* bleeding edge mesa package
    chaotic.mesa-git.enable = true;
  };
}
