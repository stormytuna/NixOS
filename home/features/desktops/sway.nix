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
    grim
    killall
    slurp
    swww
    wayfreeze
    wl-clipboard
    rofi
  ];

  # Handling wallpaper ourselves
  # TODO: Figure out later
  stylix.targets.sway.useWallpaper = false;
  home.file.".config/sway/fallback-wallpaper".source = config.stylix.image;
  home.file.".config/sway/wallpapers".source = ../styling/wallpapers;

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
        {command = "syncthing server --allow-newer-config";} # Not sure why but syncthing stopped starting its service automatically
        {command = "swww-daemon && swww img ./current-wallpaper";}
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
        "Mod4+m" = "focus down";
        "Mod4+u" = "focus up";
        "Mod4+j" = "focus right";

        # Move windows
        "Mod4+alt+h" = "move left";
        "Mod4+alt+m" = "move down";
        "Mod4+alt+u" = "move up";
        "Mod4+alt+j" = "move right";

        # Resize windows
        "Mod4+alt+ctrl+h" = "resize grow width";
        "Mod4+alt+ctrl+j" = "resize shring width";
        "Mod4+alt+ctrl+u" = "resize grow height";
        "Mod4+alt+ctrl+m" = "resize shrink height";

        # Screenshots
        # TODO: freeze with wayfreeze
        "Mod4+comma" = let
          script = pkgs.writeShellScriptBin "simpleScreenshot" ''
            grim -g "$(slurp -o -c '#ff0000ff')" -t png - | wl-copy -t image/png
            notify-send "Copied to clipboard"
          '';
        in "exec ${script.outPath}/bin/simpleScreenshot";
        "Mod4+alt+comma" = ''
          exec grim -g "$(slurp -o -c '#ff0000ff')" -t ppm - | satty --filename -
        '';

        # Other stuff
        "Mod4+t" = "exec ${pkgs.kitty}/bin/kitty";
        "Mod4+r" = "exec pkill fuzzel || fuzzel";
        "Mod4+e" = "exec thunar";
        "Mod4+q" = "kill";
        "Mod4+g" = "fullscreen toggle";
        "Mod4+alt+ctrl+shift+x" = "focus output HDMI-A-1 ; exec wlogout --protocol layer-shell --buttons-per-row 4";

        "Mod4+alt+ctrl+shift+w" = let
          css = pkgs.writeText "css.rasi" ''
            // Global
            * {
                background-color: transparent;
            }

            // Window
            window {
                background-color: rgba(0,0,0,0.76);
                fullscreen: true;
            }

            // Main Box
            mainbox {
                children: [listview];
                padding: 25% 0%;
            }

            // Listview
            listview {
                padding: 0px 10px; spacing: 10px;
                columns: 7;
                flow: horizontal;
                children: [element-icon];
            }
            element.selected {
                border-color: white;
            }
            element-icon {
                size: 229px 540px;
                /*bg-size: contain;*/
                horizontal-align: 0;
            }
          '';
          script = pkgs.writeShellScriptBin "changeWallpaper" ''
            chosenWallpaper=$(for wallpaper in ~/.config/sway/wallpapers/*
              do echo -en "$wallpaper\0icon\x1f$wallpaper\n"
            done | rofi -dmenu -show-icons -config ${css})

            cp -f "$chosenWallpaper" ~/.config/sway/current-wallpaper
            swww img ~/.config/sway/current-wallpaper --transition-type wipe --transition-angle 30 --transition-step 90
          '';
        in "exec ${script.outPath}/bin/changeWallpaper";

        "Mod4+b" = let
          script = pkgs.writeShellScriptBin "toggleMaximised" ''
            id=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true).id')
            floating_state=$(swaymsg -t get_tree | jq -r --argjson id "$id" '.. | select(.id? == $id).floating')

            swaymsg floating toggle

            if [ "$floating_state" = "auto_off" ]; then
              swaymsg move position center && \
              swaymsg resize set 90ppt 90ppt
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
          criteria = {app_id = "^thunar$";};
        }
        {
          command = "opacity 0.9";
          criteria = {class = "^vesktop$";};
        }
        {
          command = "opacity 0.9";
          criteria = {class = "^Spotify$";};
        }
        {
          command = "opacity 0.9";
          criteria = {class = "^steam$";};
        }
        {
          command = "opacity 0.9";
          criteria = {class = "^obsidian$";};
        }
        {
          command = "opacity 0.9";
          criteria = {class = "^jetbrains-rider$";};
        }
        {
          command = "floating enable ; move position center ; resize set 90ppt 90ppt";
          criteria = {app_id = "^com.gabm.satty$";};
        }
        {
          command = "fullscreen enable";
          criteria = {app_id = "^gamescope$";};
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
