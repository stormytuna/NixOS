{
  pkgs,
  config,
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
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mod = "dock";
        height = 30;
        output = ["DP-1"];

        modules-left = ["tray" "pulseaudio" "custom/notifications"];
        modules-center = [];
        modules-right = ["cpu" "custom/gpu" "memory" "clock"];

        "custom/shutdown" = {
          exec = "echo  ";
          format = "{} ";
          return-type = "";
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
          on-click = "pavucontrol";
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
          interval = 5;
        };

        memory = {
          format = " {}%  ";
          interval = 5;
          tooltip-format = ''
            {used:0.1f}GB used
            {total:0.1f}GB total
            {swapUsed:0.1f}GB swap
          '';
        };

        network = {
          format-ethernet = "  {bandwidthDownBytes}   {bandwidthUpBytes}  ";
          format-wireless = "  {bandwidthDownBytes}   {bandwidthUpBytes}  ";
          interval = 5;
        };

        clock = {
          interval = 1;
          format = "{:%a %d %b %Y | %H:%M:%S}";
          max-length = 50;
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

      ${makeModuleCssStyleString "custom-shutdown" colours.base08}
      ${makeModuleCssStyleString "pulseaudio" colours.base0A}
      ${makeModuleCssStyleString "bluetooth" colours.base0D}
      ${makeModuleCssStyleString "cpu" colours.base0B}
      ${makeModuleCssStyleString "custom-gpu" colours.base0E}
      ${makeModuleCssStyleString "memory" colours.base0A}
      ${makeModuleCssStyleString "network" colours.base09}
      ${makeModuleCssStyleString "clock" colours.base08}
      ${makeModuleCssStyleString "custom-notifications" colours.base0C}
    '';
  };

  home.file.".config/waybar/colors.css".text = ''
    @define-color base00 ${colours.base00};
    @define-color base01 ${colours.base01};
    @define-color base02 ${colours.base02};
    @define-color base03 ${colours.base03};
    @define-color base04 ${colours.base04};
    @define-color base05 ${colours.base05};
    @define-color base06 ${colours.base06};
    @define-color base07 ${colours.base07};
    @define-color base08 ${colours.base08};
    @define-color base09 ${colours.base09};
    @define-color base0A ${colours.base0A};
    @define-color base0B ${colours.base0B};
    @define-color base0C ${colours.base0C};
    @define-color base0D ${colours.base0D};
    @define-color base0E ${colours.base0E};
    @define-color base0F ${colours.base0F};
  '';
}
