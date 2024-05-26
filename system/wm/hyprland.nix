{ pkgs, userSettings, systemSettings, ... }:

{
  imports = [
    ./wayland.nix
    ./pipewire.nix
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk # Hyprland portal doesn't provide a file picker, so we use this
    ];
  };

  # TODO: Need to move out into own file and write something that works generically
  # Only actually need to worry about this when I wanna try out something other than hyprland though
  # Enable greetd and autologin and launch hyprland
  services.greetd = {
    enable = true;
    settings = {
      # Autologin
      initial_session = {
        command = "hyprland";
        user = userSettings.username;
      };
      # Display tui after logging back out
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'Welcome!' --asterisks --remember --remember-user-session --time --cmd Hyprland";
        user = userSettings.username;
      };
    };
  };
}
