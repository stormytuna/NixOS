{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.hardware.graphics;
in {
  # TODO: Option for amd and nvidia specific stuff, this is currently all just amd
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
      extraPackages = with pkgs; [amdvlk];
      extraPackages32 = with pkgs; [driversi686Linux.amdvlk];
    };

    # Force radv to be used instead of amdvlk
    environment.variables.AMD_VULKAN_ICD = "RADV";

    # *Actual* bleeding edge mesa package
    chaotic.mesa-git.enable = true;
  };
}
