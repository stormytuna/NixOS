{...}: {
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    # Required for soundcards
    alsa.enable = true;
    alsa.support32Bit = true;
  };
}
