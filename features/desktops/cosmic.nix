{pkgs, ...}: {
  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;
  };

  environment.cosmic.excludePackages = with pkgs; [
    # todo: populate this
  ];

  services.displayManager.cosmic-greeter.enable = true;

  services.system76-scheduler.enable = true;
}
