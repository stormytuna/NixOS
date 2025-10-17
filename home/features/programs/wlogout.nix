{config, ...}: let
  colours = config.lib.stylix.colors.withHashtag;
in {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "";
        keybind = "r";
      }
      {
        label = "logout";
        action = "swaymsg exit";
        text = "";
        keybind = "l";
      }
      {
        label = "firmware";
        action = "systemctl reboot --firmware-setup";
        text = "";
        keybind = "f";
      }
    ];

    style = ''
      * {
        font-family: "${config.stylix.fonts.monospace.name}";
      }

      window {
        background-color: alpha(${colours.base01}, 0.5);
      }

      button {
        margin: 500px 100px;
        color: ${colours.base05};
        font-size: 30px;
        background-color: alpha(${colours.base02}, 0.8);
        border: 5px solid ${colours.base04};
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2),
          0 6px 20px 0 rgba(0, 0, 0, 0.19);

        background-repeat: no-repeat;
        background-position: center;
        background-size: 75%;
      }

      button:hover {
        color: ${colours.base0D};
        background-color: alpha(${colours.base03}, 0.9);
        border-color: ${colours.base0D};
      }

      #shutdown {
        background-image: url("${../styling/icons/power-off.png}");
      }

      #reboot {
        background-image: url("${../styling/icons/restart.png}");
      }

      #logout {
        background-image: url("${../styling/icons/exit.png}");
      }

      #firmware {
        background-image: url("${../styling/icons/firmware.png}");
      }
    '';
  };
}
