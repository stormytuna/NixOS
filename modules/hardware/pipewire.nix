{
  config,
  lib,
  ...
}: {
  options = {
    modules.hardware.pipewire.enable = lib.mkEnableOption "Enables pipewire";
  };

  config = lib.mkIf config.modules.hardware.pipewire.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;

      # Required for soundcards
      alsa.enable = true;
      alsa.support32Bit = true;
    };
  };
}
