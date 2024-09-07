{
  config,
  lib,
  ...
}: {
  options = {
    modules.hardware.networking.enable = lib.mkEnableOption "Sets hostname and enable network manager applet";
    modules.hardware.networking.hostname = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
    };
  };

  config = lib.mkIf config.modules.hardware.networking.enable {
    networking.hostName = config.modules.hardware.networking.hostname;
    networking.networkmanager.enable = true; # Easier to use than alternative
  };
}
