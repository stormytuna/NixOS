{ pkgs, userSettings, systemSettings, ... }:

{
  imports = [
    <home-manager/nixos>
    ./waybar.nix # Status bar
    ../common/wayland.nix
    ../common/wofi.nix # Application runner
    ../common/swaync.nix # Notification manager
    (./../.. + "/shell/${userSettings.terminal}.nix") # Chosen terminal emulator
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

  programs.nm-applet.enable = true;

  services.xserver.displayManager.sddm.enable = true;

  home-manager.users.stormytuna = { ... }:
  {
    # TODO: Add modular configs
    wayland.windowManager.hyprland = {
      enable = true;

      # XWayland is needed for some apps to work
      xwayland.enable = true;

      settings = {
        "$mainMod" = "SUPER";
        "$term" = userSettings.spawnTerm;

        # Imports linked configs, see ./config
        source = [ 
          "monitors.conf"
          "startup.conf"
          "visuals.conf"
          "windowrules.conf"
          "workspaces.conf"
          "keybinds.conf"
        ];

        exec-once = "hyprctl setcursor ${userSettings.cursorSettings.name} ${builtins.toString userSettings.cursorSettings.size}";

        env = [ 
          "XKB_DEFAULT_LAYOUT, ${systemSettings.keymap}"
        ];

        input = {
          kb_layout = "${systemSettings.keymap}";
          repeat_delay = "250";
          repeat_rate = "35";
          follow_mouse = "1";

          sensitivity = 0.5;
          accel_profile = "flat";
        };

        dwindle = {
          preserve_split = "true";
        };
      };
    };

    home.file.".config/hypr/monitors.conf".source = ./conf/hyprland/monitors.conf;
    home.file.".config/hypr/startup.conf".source = ./conf/hyprland/startup.conf;
    home.file.".config/hypr/visuals.conf".source = ./conf/hyprland/visuals.${userSettings.hyprland.visuals}.conf;
    home.file.".config/hypr/windowrules.conf".source = ./conf/hyprland/windowrules.conf;
    home.file.".config/hypr/workspaces.conf".source = ./conf/hyprland/workspaces.conf;
    home.file.".config/hypr/keybinds.conf".source = ./conf/hyprland/keybinds.conf;

    home.packages = with pkgs; [
      wl-clipboard
      swww # Wallpaper daemon
      libnotify # Required to send notifications
      clipse # Clipboard history daemon
      grimblast # CLI tool for screenshots
      playerctl # CLI tool for media control
      nwg-displays # Monitor management tool
    ];
  };
}
