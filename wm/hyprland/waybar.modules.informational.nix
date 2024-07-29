{ ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.stormytuna.programs.waybar.settings.mainBar = {
    modules-left = [ "custom/shutdown" "tray" "pulseaudio" "bluetooth" ];
    modules-center = [ "hyprland/window" ];
    modules-right = [ "cpu" "custom/gpu" "memory" "network" "clock" ];
  };
}
