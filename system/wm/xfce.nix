{ pkgs, ... }:

{
  services.xserver.desktopManager.xfce = {
    enable = true;
    enableXfwm = true;
  };

  environment.systemPackages = with pkgs.xfce; [
    xfce4-notifyd # Notification daemon
    xfce4-terminal # Terminal emulator
    xfce4-settings # GUI settings menu
    xfce4-appfinder # Rofi
    xfce4-taskmanager # GUI task management tool
    xfce4-screenshotter # Screenshot tool
    xfce4-volumed-pulse # Audio controller
    xfce4-clipman-plugin # Clipboard history
    xfce4-panel
    thunar
    parole # Media player
    catfish # File searching tool
    ristretto # Image viewer
    xfdashboard # Gnome-like dashboard
  ];
}
