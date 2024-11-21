{
  config,
  lib,
  pkgs,
  ...
}: let
  colours = config.lib.stylix.colors.withHashtag;
  makeModuleCssStyleString = module: colour: ''
    #${module} {
      color: ${colour};
      border-color: ${colour};
    }
  '';
in {
  options.modules.programs.waybar = {
    enable = lib.mkEnableOption "Wayland status bar";
  };

  config = lib.mkIf config.modules.programs.waybar.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          mod = "dock";
          height = 30;
          output = ["DP-1"];

          modules-left = ["tray" "pulseaudio"];
          modules-center = ["cpu" "custom/gpu" "memory" "network"];
          modules-right = ["clock"];

          "custom/shutdown" = {
            exec = "echo ";
            format = "{} ";
            return-typ = "";
            interval = "once";
            on-click = "${pkgs.wlogout}/bin/wlogout";
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
              default = ["" "" ""];
            };
            scroll-step = 1;
            on-click = "hyprctl dispatch togglespecialworkspace pavucontrol && hyprctl dispatch bringactivetotop";
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
            exec = "cat /sys/class/hwmon/hwmon*/device/gpu_busy_percent";
            format = " {}% 󰝤 ";
            return-type = "";
            interval = 5;
          };

          memory = {
            format = " {}%  ";
            interval = 5;
          };

          network = {
            format-ethernet = "  {bandwidthDownBytes}   {bandwidthUpBytes}  ";
            format-wireless = "  {bandwidthDownBytes}   {bandwidthUpBytes}  ";
            interval = 5;
          };

          clock = {
            interval = 1;
            format = "{:%Y-%m-%d | %H:%M:%S}";
            max-length = 25;
          };
        };
      };

      style = ''
        * {
          font-family: "${config.stylix.fonts.monospace.name}";
          font-weight: bold;
          font-size: 12px;
        }

        window#waybar {
          background: alpha(${colours.base00}, 0.7);
        }

        tooltip {
          background: ${colours.base02};
          border: ${colours.base01} solid 2px;
          border-radius: 8px;
        }

        .module {
          padding: 2px 10px;
          color: ${colours.base06};
        }

        ${makeModuleCssStyleString "pulseaudio" colours.base0A}
        ${makeModuleCssStyleString "bluetooth" colours.base0D}
        ${makeModuleCssStyleString "cpu" colours.base0B}
        ${makeModuleCssStyleString "custom-gpu" colours.base0E}
        ${makeModuleCssStyleString "memory" colours.base0A}
        ${makeModuleCssStyleString "network" colours.base09}
        ${makeModuleCssStyleString "clock" colours.base08}
      '';
    };
  };
}
