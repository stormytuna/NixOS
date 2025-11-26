{lib, pkgs, ...}: {
  security.polkit.enable = true;
  programs.dconf.enable = true;

  # Autologin
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd sway";
        user = "stormytuna";
      };
      initial_session = {
        command = "sway";
        user = "stormytuna";
      };
    };
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      # Required for gtk apps
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;

	extraSessionCommands = ''
      export GTK_USE_PORTAL=1
      export XCURSOR_SIZE=28
      export XCURSOR_THEME="Bibata Modern Ice"
	'';
  };

  environment.systemPackages = with pkgs; [
    bibata-cursors # Cursor theme
    dunst # Notification daemon
    sox # Used in some scripts
    grim # Screenshot tool
    killall # Used in some scripts
    kitty # Terminal emulator
    rofi # Menu tool
    fuzzel # App launcher
    satty # Screenshot editing tool
    slurp # Area selection tool
    syncthing # File syncing service
    swww # Wallpaper daemon
    waybar # Status bar
    wayfreeze # Screen freezer
    wl-clipboard # Clipboard management
    wlsunset # Screen orange-ifier
    wlogout # Logout screen
  ];
}
