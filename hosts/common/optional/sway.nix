{pkgs, ...}: {
  security.polkit.enable = true;
  programs.dconf.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "stormytuna";
      };
    };
  };

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };
}
