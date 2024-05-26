{ ... }:

{
  programs.waybar.settings.mainBar = {
    modules-left = [ "tray" "pulseaudio" ];
    modules-right = [ "clock" ];
  };
}
