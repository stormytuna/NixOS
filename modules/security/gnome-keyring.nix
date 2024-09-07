{
  config,
  lib,
  ...
}: {
  options = {
    modules.security.gnome-keyring.enable = lib.mkEnableOption "Enables gnome keyring";
  };

  config = lib.mkIf config.modules.security.gnome-keyring.enable {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.sddm.enableGnomeKeyring = true;
  };
}
