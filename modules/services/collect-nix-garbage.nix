{
  config,
  lib,
  ...
}: {
  options = {
    modules.services.collectNixGarbage.enable = lib.mkEnableOption "Enables nix-collect-garbage systemd service";
    modules.services.collectNixGarbage.options = lib.mkOption {
      default = "--delete-older-than 14d";
      description = "Options passed to nix-collect-garbage command. Defaults to '--delete-older-than 14d'";
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.modules.services.collectNixGarbage.enable {
    # nix.gc was throwing on rebuilds so just made systemd service
    systemd.services.cleanupgarbage = {
      enable = true;
      serviceConfig = {
        ExecStart = "nix-collect-garbage ${config.modules.services.collectNixGarbage.options}";
      };
    };
  };
}
