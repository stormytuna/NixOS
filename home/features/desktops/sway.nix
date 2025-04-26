{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-wlr];
    configPackages = [pkgs.xdg-desktop-portal-wlr];
  };

  services.wlsunset = {
    enable = true;
    latitude = 53.8;
    longitude = 1.5;
  };

  home.packages = with pkgs; [
    wl-clipboard
  ];

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    wrapperFeatures.gtk = true; # Fix issues with GTK 3 apps

    config = {
      up = "k";
      down = "j";
      left = "h";
      right = "l";
      modifier = "Mod4";

      terminal = "${pkgs.kitty}/bin/kitty";
      menu = "${pkgs.wofi}/bin/wofi";

      bars = [
        {command = "${pkgs.waybar}/bin/waybar";}
      ];

      window.titlebar = false;

      output = {
        "DP-1" = {
          pos = "0 240";
          res = "1920x1080@144Hz";
          transform = "270";
        };
        "DP-3" = {
          pos = "4920 361";
          res = "2560x1440@120.02Hz";
        };
        "HDMI-A-1" = {
          pos = "1080 0";
          res = "3840x2160@119.88Hz";
        };
      };

      startup = [
        {command = "steam -silent";}
        {command = "${pkgs.blueman}/bin/blueman-applet";}
        {command = "${pkgs.networkmanagerapplet}/bin/nm-applet";}
        {command = "sleep 5 && ${pkgs.vesktop}/bin/vesktop";} # Sleep to prevent breaking on early startup
      ];

      gaps = {
        outer = 8;
        inner = 4;
        smartGaps = false;
      };

      keybindings = {
        # Switch workspace
        "Mod4+x" = "workspace 1";
        "Mod4+v" = "workspace 3";
        "Mod4+c" = "workspace 2";
        "Mod4+s" = "workspace 4";
        "Mod4+d" = "workspace 5";
        "Mod4+f" = "workspace 6";

        # Move window to workspace
        "Mod4+shift+x" = "move container to workspace 1; workspace 1";
        "Mod4+shift+v" = "move container to workspace 3; workspace 3";
        "Mod4+shift+c" = "move container to workspace 2; workspace 2";
        "Mod4+shift+s" = "move container to workspace 4; workspace 4";
        "Mod4+shift+d" = "move container to workspace 5; workspace 5";
        "Mod4+shift+f" = "move container to workspace 6; workspace 6";

        # Move focus
        "Mod4+h" = "focus left";
        "Mod4+j" = "focus down";
        "Mod4+k" = "focus up";
        "Mod4+l" = "focus right";

        # Move windows
        "Mod4+shift+h" = "move left";
        "Mod4+shift+j" = "move down";
        "Mod4+shift+k" = "move up";
        "Mod4+shift+l" = "move right";

        # Screenshots
        "Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify savecopy area ~/Pictures/Screenshots/Area_$(date +'%Y-%m-%d_%H-%M-%S').png";
        "shift+print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify savecopy output ~/Pictures/Screenshots/Output_$(date +'%Y-%m-%d_%H-%M-%S').png";

        # Other stuff
        "Mod4+t" = "exec ${pkgs.kitty}/bin/kitty";
        "Mod4+r" = "exec pkill wofi || ${pkgs.wofi}/bin/wofi --show drun --allow-images";
        "Mod4+q" = "kill";
        "Mod4+g" = "fullscreen toggle";
        "Mod4+b" = "floating toggle";
        "Mod4+alt+control+shift+x" = "${pkgs.wlogout}/bin/wlogout";
        "Mod4+alt+control+shift+c" = "exec pkill waybar || ${pkgs.waybar}/bin/waybar";
      };

      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "DP-1";
        }
        {
          workspace = "3";
          output = "DP-2";
        }
        {
          workspace = "2";
          output = "HDMI-A-1";
        }
        {
          workspace = "4";
          output = "HDMI-A-1";
        }
        {
          workspace = "5";
          output = "HDMI-A-1";
        }
        {
          workspace = "6";
          output = "HDMI-A-1";
        }
      ];

      input = {
        "*" = {
          repeat_delay = "250";
          repeat_rate = "35";
          accel_profile = "flat";
          pointer_accel = "0.5";
        };
      };

      window.commands = [
        {
          command = "opacity 0.85";
          criteria = {app_id = "kitty";};
        }
      ];

      assigns = {
        # Move discord and vesktop to left
        "1" = [{class = "^discord$";} {class = "^vesktop";}];

        # Move games to gaming workspace
        "5" = [
          {app_id = "^gamescope$";}
        ];
      };
    };
  };
}
