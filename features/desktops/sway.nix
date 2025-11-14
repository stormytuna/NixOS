{lib, pkgs, ...}: {
  security.polkit.enable = true;
  programs.dconf.enable = true;

  # Autologin
  services.greetd = let
    sway-launcher = pkgs.writeScript "sway-launcher.sh" ''
      export GTK_USE_PORTAL=1
      exec sway
    '';
  in {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd ${sway-launcher}";
        user = "stormytuna";
      };
      initial_session = {
        command = "${sway-launcher}";
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
    swww # Wallpaper daemon
    waybar # Status bar
    wayfreeze # Screen freezer
    wl-clipboard # Clipboard management
    wlsunset # Screen orange-ifier
    wlogout # Logout screen
  ];
}
