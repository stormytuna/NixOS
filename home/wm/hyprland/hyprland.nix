{ pkgs, userSettings, systemSettings, ... }:

{
  imports = [
    ./waybar.nix # Status bar
    ./wofi.nix # Application runner
    ./../common/swaync.nix # Notification manager
  ];

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
      };

      dwindle = {
        preserve_split = "true";
      };

      master = {
        new_is_master = "true";
      };
    };
  };

  home.file.".config/hypr/monitors.conf".source = ../../config/hypr/monitors.conf;
  home.file.".config/hypr/startup.conf".source = ../../config/hypr/startup.conf;
  home.file.".config/hypr/visuals.conf".source = ../../config/hypr/visuals.${userSettings.hyprland.visuals}.conf;
  home.file.".config/hypr/windowrules.conf".source = ../../config/hypr/windowrules.conf;
  home.file.".config/hypr/workspaces.conf".source = ../../config/hypr/workspaces.conf;
  home.file.".config/hypr/keybinds.conf".source = ../../config/hypr/keybinds.conf;

  home.packages = with pkgs; [
    wl-clipboard
    swww # Wallpaper daemon
    clipse # Clipboard history daemon
    grimblast # CLI tool for screenshots
    playerctl # CLI tool for media control
  ];
}
