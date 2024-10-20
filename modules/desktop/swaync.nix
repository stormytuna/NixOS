{
  config,
  lib,
  pkgs,
  ...
}: let
  sounds = pkgs.callPackage ../../packages/enchanted-sound-theme.nix {};
in {
  imports = [<home-manager/nixos>];

  options = {
    modules.desktop.swaync.enable = lib.mkEnableOption "Enables swaync, a notification daemon";
  };

  config = lib.mkIf config.modules.desktop.swaync.enable {
    home-manager.users.stormytuna.services.swaync = {
      enable = true;
      settings = {
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        control-center-layer = "top";
        layer-shell = true;
        cssPriority = "application";
        control-center-margin-top = 10;
        control-center-margin-bottom = 10;
        control-center-margin-right = 10;
        control-center-margin-left = 10;
        notification-2fa-action = true;
        notification-inline-replies = false;
        notification-icon-size = 64;
        notification-body-image-height = 100;
        notification-body-image-width = 200;
        timeout = 5;
        timeout-low = 5;
        timeout-critical = 0;
        fit-to-screen = true;
        relative-timestamps = true;
        control-center-width = 500;
        control-center-height = 600;
        notification-window-width = 500;
        keyboard-shortcuts = true;
        image-visibility = "when-available";
        transition-time = 200;
        hide-on-clear = true;
        hide-on-action = true;
        script-fail-notify = true;
        notification-visibility = {
          mute-spotify = {
            state = "muted";
            urgency = "Low";
            app-name = "Spotify";
          };
        };
        widgets = [
          "inhibitors"
          "title"
          "dnd"
          "notifications"
        ];
        widget-config = {
          inhibitors = {
            text = "Inhibitors";
            button-text = "Clear All";
            clear-all-button = true;
          };
          title = {
            text = "Notifications";
            clear-all-button = true;
            button-text = "Clear All";
          };
          dnd = {
            text = "Do Not Disturb";
          };
          mpris = {
            image-size = 96;
            image-radius = 12;
          };
        };
        scripts = {
          play-sound = {
            exec = "${pkgs.sox}/bin/play ${sounds}/stereo/bell.ogg";
            app-name = "^(?!.*(vesktop|discord)).*$"; # Don't apply to vesktop or discord
            urgency = "Normal";
          };
        };
      };
    };
  };
}
