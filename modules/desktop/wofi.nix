{
  config,
  lib,
  ...
}: let
  colours = config.lib.stylix.colors.withHashtag;
in {
  imports = [<home-manager/nixos>];

  options = {
    modules.desktop.wofi.enable = lib.mkEnableOption "Enables wofi, a wayland app launcher";
  };

  config = lib.mkIf config.modules.desktop.wofi.enable {
    home-manager.users.stormytuna.programs.wofi = {
      enable = true;

      settings = {
        width = "40%";
        height = "30%";
        hide_scroll = true;
        image_size = 48;
        insensitive = true;
      };

      style = lib.mkForce ''
        * {
          font-family: "${config.modules.stylix.fonts.monospace.name}";
          font-size: 20px;

          border-color: "${colours.base02}";
        }

        #input {
          margin-left: 4em;
          margin-right: 4em;
          margin-bottom: 1em;
          padding: 0.5em;

          border: ${colours.base03} solid 2px;
          border-radius: 500px;
          background-color: "${colours.base00}";
        }

        #window {
          background-color: transparent;
        }

        #inner-box {
          margin: 0.5em;
          padding: 0.5em;

          background: transparent;
        }

        #img {
          margin-right: 0.5em;
        }

        #entry {
          padding: 0.4em;
        }

        #entry:nth-child(odd) {
          background-color: ${colours.base00};
        }

        #entry:nth-child(even) {
          background-color: ${colours.base01};
        }

        #entry:selected {
          background-color: ${colours.base02};
          outline: ${colours.base03} solid 0px;
        }
      '';
    };
  };
}
