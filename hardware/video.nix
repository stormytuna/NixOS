{ pkgs, ... }:

{
  # GPU drivers
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ amdvlk ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  };

  # Force radv to be used instead of amdvlk
  environment.variables.AMD_VULKAN_ICD = "RADV";

  # Using chaotic nyx for *actual* bleeding edge mesa package
  chaotic.mesa-git.enable = true;
}
