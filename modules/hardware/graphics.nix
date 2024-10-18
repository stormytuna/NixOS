{
  config,
  lib,
  pkgs,
  pkgs-stable,
  ...
}: let
  cfg = config.modules.hardware.graphics;
in {
  options = {
    modules.hardware.graphics.enable = lib.mkEnableOption "Enables various options for graphics";
  };

  config = lib.mkIf cfg.enable {
    # GPU drivers
    services.xserver.enable = true;
    services.xserver.videoDrivers = ["amdgpu"];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs-stable; [amdvlk];
      extraPackages32 = with pkgs-stable; [driversi686Linux.amdvlk]; # 2024/10/18 - Was blocking builds, didnt look into it
    };

    # Force radv to be used instead of amdvlk
    environment.variables.AMD_VULKAN_ICD = "RADV";

    # *Actual* bleeding edge mesa package
    chaotic.mesa-git.enable = true;
  };
}
