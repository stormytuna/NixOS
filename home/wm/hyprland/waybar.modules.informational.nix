{ ... }:

{
  programs.waybar.settings.mainBar = {
    modules-left = [ "custom/shutdown" "tray" "pulseaudio" "bluetooth" ];
    modules-center = [ "hyprland/window" ];
    modules-right = [ "cpu" "custom/gpu" "memory" "network" "clock" ];
  };
}
