{
  config,
  lib,
  ...
}: {
  options.modules.desktops.hyprland = {
    enable = lib.mkEnableOption "Tiling Wayland compositor";
  };

  config = lib.mkIf config.modules.desktops.hyprland.enable {
    # Required even though our config is in home-manager as this enables critical system stuff for Hyprland to work
    # https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
    programs.hyprland.enable = true;
  };
}
