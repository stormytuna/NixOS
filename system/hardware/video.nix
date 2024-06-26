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

  # Using chaotic nyx for *actual* bleeding edge mesa package
  chaotic.mesa-git.enable = true;
}
