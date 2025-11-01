{pkgs, ...}: {
  security.polkit.enable = true;
  programs.dconf.enable = true;

  services.greetd = {
    enable = true;
    settings = rec {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd sway";
        user = "stormytuna";
      };
      initial_session = {
        command = "sway";
        user = "stormytuna";
      };
    };
  };

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };
}
