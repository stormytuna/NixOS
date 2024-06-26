{ userSettings, pkgs, ... }:

{
  # Import our chosen configs
  imports = [ (./. + "/waybar.modules.${userSettings.waybar.modules}.nix") ];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        # General waybar configs
        layer = "top";
        position = "top";
        mod = "dock";
        height = 30;

        # Module configs
        "custom/shutdown" = {
          exec = "echo ";
          format = "{} ";
          return-typ = "";
          interval = "once";
          on-click = "wlogout -b 2";
        };

        tray = {
          spacing = 5;
        };

        "custom/notifications" = {
          tooltip = false;
          format = "{}  ";
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        pulseaudio = {
          format = "{volume}% {icon} ";
          format-icons = {
            headphone = "";
            default = [ "" "" "" ];
          };
          scroll-step = 1;
          on-click = "hyprctl dispatch togglespecialworkspace pavucontrol && hyprctl dispatch bringactivetotop";
          #on-click-right = "~/.config/waybar/scripts/audio_changer.py"; # TODO: make own script for this!
        };

        bluetooth = {
          format = " {device_alias} - {status}";
        };

        "hyprland/window" = {
          format = "> {initialTitle}";
          separate-outputs = true;
        };

        mpris = {
          format = "{player_icon}  | {title} | {artist} ({position}/{length})";
          tooltip-format = "";
          player-icons = {
            default = "";
            firefox = "";
            spotify = "";
          };
          status-icons = {
            paused = "";
            playing = "";
          };
          interval = 1;
        };

        cpu = {
          format = " {usage}%  ";
          interval = 5;
        };

        "custom/gpu" = {
          exec = "cat /sys/class/hwmon/hwmon2/device/gpu_busy_percent"; # TODO: Script to automagically find correct device?
            format = " {}%  ";
          return-type = "";
          interval = 5;
        };

        memory = {
          format = " {}%  ";
          interval = 5;
        };

        network = {
          format-ethernet = "{ipaddr}  | {bandwidthDownBytes}   {bandwidthUpBytes}  ";
          format-wireless = "{ipaddr}  | {bandwidthDownBytes}   {bandwidthUpBytes}  ";
          interval = 5;
        };

        clock = {
          interval = 1;
          format = "{:%Y-%m-%d | %H:%M:%S}";
          max-length = 25;
        };
      };
    };
  };

  home.file.".config/waybar/style.css".source = ../../config/waybar/style.css;
}
