{ pkgs, userSettings, inputs, ... }:

{
  imports = [
    ./waybar.nix # Status bar
    ./../common/swaync.nix # Notification manager
  ];

  # TODO: Add modular configs
  wayland.windowManager.hyprland = {
    enable = true;

    # XWayland is needed for some apps to work
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";

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
        "XKB_DEFAULT_LAYOUT, gb"
      ];

      input = {
        kb_layout = "gb";
        repeat_delay = "150";
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

  home.file.".config/hypr/monitors.conf".source = ./config/monitors.conf;
  home.file.".config/hypr/startup.conf".source = ./config/startup.conf;
  home.file.".config/hypr/visuals.conf".source = ./config/visuals.conf;
  home.file.".config/hypr/windowrules.conf".source = ./config/windowrules.conf;
  home.file.".config/hypr/workspaces.conf".source = ./config/workspaces.conf;
  home.file.".config/hypr/keybinds.conf".source = ./config/keybinds.conf;

  home.packages = with pkgs; [
    wl-clipboard
    wofi # TODO: switch to rofi
    swww # Wallpaper daemon
    clipse # Clipboard history daemon
    grimblast # CLI tool for screenshots
    playerctl # CLI tool for media control
  ];
}
