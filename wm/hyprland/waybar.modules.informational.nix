{...}: {
  imports = [<home-manager/nixos>];

  home-manager.users.stormytuna.programs.waybar.settings.mainBar = {
    modules-left = ["tray" "pulseaudio"];
    modules-center = ["hyprland/window"];
    modules-right = ["cpu" "custom/gpu" "memory" "network" "clock"];
  };
}
