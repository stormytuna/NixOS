{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.services.auto-update;
in {
  options.modules.services.auto-update = {
    enable = lib.mkEnableOption "Automatically updates home-manager configuration";
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.auto-update = {
      Unit = {
        Description = "Automatically updates home-manager configuration";
      };
      Service = {
        ExecStart = "${pkgs.writeShellScript "update-home"} ''

        ''";
      };
    };
  };
}
