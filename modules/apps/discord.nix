{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.apps.discord.enable = lib.mkEnableOption "Enables discord and vesktop";
  };

  config = lib.mkIf config.modules.apps.discord.enable {
    # TODO: Figure out how to apply krisp patch

    environment.systemPackages = with pkgs; [
      (discord.override {
        withVencord = true;
      })
    ];
  };
}
