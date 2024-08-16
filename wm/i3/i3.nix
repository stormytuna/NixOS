{pkgs, ...}: {
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+i3";

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu # Application launcher
        i3status # Status bar
        i3lock # Screen lock
      ];
    };
  };

  home-manager.users.stormytuna = {
    xsession.windowManager.i3.config = {
      # TODO: Finish!
    };
  };
}
