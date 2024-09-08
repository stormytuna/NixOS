{
  config,
  lib,
  pkgs,
  pkgs-stable,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
in {
  imports = [<home-manager/nixos>];

  options = {
    modules.desktop.hyprland.enable = lib.mkEnableOption "Enables Hyprland, a wayland compositor";
  };

  config = lib.mkIf cfg.enable {
    modules.desktop = {
      sddm = {
        enable = true;
        wayland = true;
      };

      wofi.enable = true;
      waybar.enable = true;
    };

    programs.nm-applet.enable = true;

    environment.systemPackages = with pkgs; [
      wl-clipboard
      libnotify
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk # Hyprland portal doesn't provide a file picker
      ];
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs-stable.xdg-desktop-portal-hyprland;
    };

    home-manager.users.stormytuna = {
      services.hyprpaper.package = pkgs-stable.hyprpaper;

      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;

        settings = {
          "$mainMod" = "SUPER";
          "$spawnTerminal" = "alacritty"; # TODO: Make a spawnterm thingy somewhere?

          exec-once =
            [
              "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
              "waybar" # TODO: Optional if we enable it or not
              "${pkgs.clipse}/bin/clipse -listen"
              "${pkgs.blueman}/bin/blueman-applet"
              "${pkgs.swaynotificationcenter}/bin/swaync" # TODO: Move to module
              "${pkgs.networkmanagerapplet}/bin/nm-applet"
            ]
            ++ (lib.optionals config.modules.apps.vesktop.enable [
              "${pkgs.vesktop}/bin/vesktop"
            ])
            ++ (lib.optionals config.modules.apps.gaming.enable [
              "steam -silent"
            ]);

          monitor = [
            "DP-1, 1920x1080@60.0, 0x240, 1.0"
            "DP-1, transform, 1"
            "DP-3, 2560x1440@120.02, 4920x361, 1.0"
            "HDMI-A-1, 3840x2160@119.88, 1080x0, 1.0, bitdepth, 10"
          ];

          workspace = [
            "name:left1, monitor:DP-1, default:true"
            "name:right1, monitor:DP-3, default:true"
            "name:main1, monitor:HDMI-A-1, default:true"
            "name:main2, monitor:HDMI-A-1"
            "name:main3, monitor:HDMI-A-1"
            "name:gaming, monitor:HDMI-A-1, rounding:false, decorate:false, border:false, gapsin:0, gapsout:0"

            # Scratchpads # TODO: Want to try the plugin for them as well
            "special:pavucontrol, on-created-empty:${pkgs.pavucontrol}/bin/pavucontrol, gapsout:100"
            "special:terminal, on-created-empty:$spawnTerminal, gapsout:100"
            "special:spotify, on-created-empty:env LD_PRELOAD=/usr/lib/spotify-adblock.so spotify, gapsout:100"
            "special:clipse, on-created-empty:$spawnTerminal -e zsh -c 'clipse $PPID', gapsout:100"
            "special:github-desktop, on-created-empty:${pkgs.github-desktop}/bin/github-desktop, gapsout:100"
            "special:lutris, on-created-empty:lutris, gapsout:50"
          ];

          bind = [
            # Switch workspace
            "$mainMod, C, workspace, name:main1"
            "$mainMod, X, workspace, name:left1"
            "$mainMod, V, workspace, name:right1"
            "$mainMod, D, workspace, name:gaming"
            "$mainMod, S, workspace, name:main2"
            "$mainMod, F, workspace, name:main3"

            # Move window to workspace
            "$mainMod SHIFT, C, movetoworkspace, name:main1"
            "$mainMod SHIFT, X, movetoworkspace, name:left1"
            "$mainMod SHIFT, V, movetoworkspace, name:right1"
            "$mainMod SHIFT, D, movetoworkspace, name:gaming"
            "$mainMod SHIFT, S, movetoworkspace, name:main2"
            "$mainMod SHIFT, F, movetoworkspace, name:main3"

            # Open scratchpads
            "$mainMod ALT, C, exec, hyprctl dispatch togglespecialworkspace terminal"
            "$mainMod ALT, X, exec, hyprctl dispatch togglespecialworkspace spotify"
            "$mainMod ALT, V, exec, hyprctl dispatch togglespecialworkspace pavucontrol"
            "$mainMod ALT, D, exec, hyprctl dispatch togglespecialworkspace clipse"
            "$mainMod ALT, S, exec, hyprctl dispatch togglespecialworkspace github-desktop"
            "$mainMod ALT, F, exec, hyprctl dispatch togglespecialworkspace lutris"

            # Move focus
            "$mainMod, H, movefocus, l"
            "$mainMod, J, movefocus, d"
            "$mainMod, K, movefocus, u"
            "$mainMod, L, movefocus, r"

            # Move windows
            "$mainMod SHIFT, H, movewindow, l"
            "$mainMod SHIFT, J, movewindow, d"
            "$mainMod SHIFT, K, movewindow, u"
            "$mainMod SHIFT, L, movewindow, r"

            # Screenshots
            ", Print, exec, ${pkgs.grimblast}/bin/grimblast --notify --freeze copysave area ~/Pictures/Screenshots/Area_$(date +'%Y-%m-%d_%H-%M-%S').png"
            "SHIFT, Print, exec, ${pkgs.grimblast}/bin/grimblast --notify --freeze copysave output ~/Pictures/Screenshots/Output_$(date +'%Y-%m-%d_%H-%M-%S').png"

            # Emoji picker
            "CTRL SHIFT, E, exec, ${pkgs.wofi-emoji}/bin/wofi-emoji"

            "$mainMod, T, exec, $spawnTerminal"
            "$mainMod, Q, exec, hyprctl dispatch killactive"
            "$mainMod, B, togglefloating"
            "$mainMod, G, fullscreen"
            "$mainMod, W, togglesplit"
            "$mainMod, A, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t -s"
            "$mainMod, R, exec, pkill wofi || ${pkgs.wofi}/bin/wofi --show drun --allow-images"
            "$mainMod ALT SHIFT, X, exit"
          ];

          windowrulev2 = [
            # Make terminal transparent
            "opacity 0.9 0.9, class:^(kitty)$"
            "opacity 0.9 0.9, class:^(Alacritty)$"

            # Move games to dedicated workspace
            "workspace name:gaming silent, class:^(gamescope)$"
            "fullscreen, class:^(gamescope)$"

            # Move discord and vesktop to the left
            "workspace name:left1 silent, class:^(discord)$"
            "workspace name:left1 silent, class:^(vesktop)$"
          ];

          input = {
            repeat_delay = "250";
            repeat_rate = "35";
            follow_mouse = "1";
            accel_profile = "flat";
          };
        };
      };
    };
  };
}
