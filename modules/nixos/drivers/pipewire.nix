{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.drivers.pipewire = {
    enable = lib.mkEnableOption "Audio and video stream handler";
  };

  config = lib.mkIf config.modules.drivers.pipewire.enable {
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
