{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.portal = rec {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    configPackages = extraPortals;
  };

  home.packages = with pkgs; [
    wl-clipboard
  ];

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    wrapperFeatures.gtk = true; # Fix issues with GTK 3 apps

    package = pkgs.swayfx;
    checkConfig = false; # Required for swayfx package

    config = {
      up = "k";
      down = "j";
      left = "h";
      right = "l";
      modifier = "Mod4";

      terminal = "${pkgs.kitty}/bin/kitty";
      menu = "fuzzel";

      window.titlebar = false;

      bars = [];

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
        # Should always be on path, but defined in system so can't do these optionally
        {command = "blueman-applet";}
        {command = "nm-applet";}
        {command = "steam -silent -forcedesktopscaling=1.75";}
        {command = "sleep 5 && vesktop";}
        #{command = "sleep 3 && eww daemon && eww open main";}
        {command = "waybar";}
        {command = "syncthing server";} # Not sure why but syncthing stopped starting its service automatically
      ];

      gaps = {
        outer = 12;
        inner = 8;
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
        #"Print" = "exec flameshot gui";
        "Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify savecopy area $XDG_PICTURES_DIR/screenshots/area_$(date +'%Y-%m-%d_%H-%M-%S').png";

        # Other stuff
        "Mod4+t" = "exec ${pkgs.kitty}/bin/kitty";
        "Mod4+r" = "exec pkill fuzzel || fuzzel";
        "Mod4+e" = "exec thunar";
        "Mod4+q" = "kill";
        "Mod4+g" = "fullscreen toggle";
        "Mod4+alt+ctrl+shift+x" = "focus output HDMI-A-1 ; exec wlogout --protocol layer-shell --buttons-per-row 4";

        "Mod4+b" = let
          script = pkgs.writeShellScriptBin "toggleMaximised" ''
            id=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true).id')
            floating_state=$(swaymsg -t get_tree | jq -r --argjson id "$id" '.. | select(.id? == $id).floating')

            swaymsg floating toggle

            if [ "$floating_state" = "auto_off" ]; then
              swaymsg move position center
              swaymsg resize set width 90ppt
              swaymsg resize set height 90ppt
            fi
          '';
        in "exec ${script.outPath}/bin/toggleMaximised";
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
          command = "opacity 0.9";
          criteria = {app_id = "^kitty$";};
        }
        {
          command = "opacity 0.9";
          criteria = {app_id = "^zen$";};
        }
        {
          command = "opacity 0.9";
          criteria = {app_id = "^vesktop$";};
        }
        {
          command = "opacity 0.9";
          criteria = {class = "^jetbrains-rider$";};
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

      # Remove stupid next window indicator border line
      colors = lib.mkForce (with config.lib.stylix.colors.withHashtag; let
        text = base05;
        urgent = base08;
        focused = base0D;
        unfocused = base03;
        background = base00;
        clear = "#ffffff00";
      in {
        inherit background;
        focused = {
          inherit background text;
          indicator = focused;
          border = focused;
          childBorder = focused;
        };
        focusedInactive = {
          inherit background text;
          indicator = unfocused;
          border = unfocused;
          childBorder = unfocused;
        };
        unfocused = {
          inherit background text;
          indicator = unfocused;
          border = unfocused;
          childBorder = unfocused;
        };
        urgent = {
          inherit background text;
          indicator = urgent;
          border = urgent;
          childBorder = urgent;
        };
        placeholder = {
          inherit background text;
          indicator = unfocused;
          border = unfocused;
          childBorder = unfocused;
        };
      });
    };

    # SwayFX config here as above modules aren't configured to take any random attribute set
    extraConfig = ''
      blur enable
      blur_passes 5
      blur_radius 1

      shadows enable
      shadow_blur_radius 40

      layer_effects "logout_dialog" blur enable
      layer_effects "waybar" blur enable
    '';
  };
}
