{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.desktops.gnome = {
    enable = lib.mkEnableOption "GTK-based desktop manager";
  };

  config = lib.mkIf config.modules.desktops.gnome.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.systemPackages = [pkgs.gnome-tweaks];

    programs.dconf.enable = true;

    # Remove useless garbage
    environment.gnome.excludePackages = with pkgs; [
      gnome-photos
      gnome-tour
      cheese
      gnome-music
      gedit
      epiphany
      geary
      gnome-characters
      tali
      iagno
      hitori
      atomix
      yelp
      gnome-contacts
      gnome-initial-setup
    ];
  };
}
