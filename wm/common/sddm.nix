{ pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-sddm-corners";
  };

  environment.systemPackages = [
    pkgs.catppuccin-sddm-corners
  ];
}
