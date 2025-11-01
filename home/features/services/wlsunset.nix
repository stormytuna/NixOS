{
  config,
  pkgs,
  ...
}: {
  home.packages = [config.services.wlsunset.package];

  services.wlsunset = {
    enable = true;
    package = pkgs.wlsunset;
    latitude = 53.8;
    longitude = 1.5;
    temperature = {
      night = 4000;
    };
  };
}
