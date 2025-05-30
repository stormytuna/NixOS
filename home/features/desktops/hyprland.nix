{pkgs, ...}: {
  home.packages = with pkgs; [
    wl-clipboard # neovim won't use system clipboard otherwise
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$spawnTerminal" = "kitty"; # TODO: remove

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "waybar" # TODO: optional
        "${pkgs.clipse}/bin/clipse --listen"
        "${pkgs.blueman}/bin/blueman-applet" # TODO: optional
        "${pkgs.networkmanagerapplet}/bin/nm-applet" # TODO: optional
        "sleep 5; ${pkgs.vesktop}/bin/vesktop" # TODO: optional
        "steam --silent" # TODO: optional
      ];

      monitor = [
        "HDMI-A-1, 3840x2160@119.88, 1080x0, 1, bitdepth, 10"
        "DP-1, 1920x1080@144.0, 0x240, 1"
        "DP-1, transform, 1"
        "DP-3, 2560x1440@120.02, 4920x361, 1"
      ];

      workspace = [
        "name:left1, monitor:DP-1, default:true"
        "name:right1, monitor:DP-3, default:true"
        "name:main1, monitor:HDMI-A-1, default:true"
        "name:main2, monitor:HDMI-A-1"
        "name:main3, monitor:HDMI-A-1"
        "name:gaming, monitor:HDMI-A-1, rounding:false, decorate:false, border:false, gapsin:0, gapsout:0"
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
        ", Print, exec, ${pkgs.hyprshot}/bin/hyprshot --mode region --output-folder ~/Pictures/Screenshots"
        "SHIFT, Print, exec, ${pkgs.hyprshot}/bin/hyprshot --mode output --output-folder ~/Pictures/Screenshots"

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

      general = {
        border_size = 2;
      };

      decoration = {
        rounding = 5;

        blur = {
          size = 3;
          passes = 3;
          xray = true;
          special = true;
        };

        shadow = {
          range = 10;
        };
      };

      animations = {
        bezier = ["easeOutExpo, 0.16, 1, 0.3, 1"];
        animation = [
          "windows, 1, 6, easeOutExpo, gnomed"
          "layers, 1, 4, easeOutExpo, slide"
          "workspaces, 1, 3, easeOutExpo, slidevert"
        ];
      };
    };
  };
}
