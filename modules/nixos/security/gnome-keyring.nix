{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.security.gnome-keyring = {
    enable = lib.mkEnableOption "Secret, password, key and certificate manager";
  };

  config = lib.mkIf config.modules.security.gnome-keyring.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}
