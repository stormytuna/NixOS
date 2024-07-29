{ ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.stormytuna.programs.waybar.settings.mainBar = {
    modules-left = [ "tray" "pulseaudio" ];
    modules-right = [ "clock" ];
  };
}
