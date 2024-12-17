{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.services.greetd = {
    enable = lib.mkEnableOption "Minimal and flexible login manager";
  };

  config = lib.mkIf config.modules.services.greetd.enable {
    services.greetd = {
      enable = true;
      package = pkgs.greetd.tuigreet;
      settings =
        {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
            user = "greeter";
          };
        }
        // lib.attrsets.optionalAttrs config.modules.desktops.hyprland.enable {
          initial_session = {
            command = "Hyprland";
            user = "stormytuna";
          };
        }
        // lib.attrsets.optionalAttrs config.modules.desktops.sway.enable {
          initial_session = {
            command = "sway";
            user = "stormytuna";
          };
        };
    };
  };
}
