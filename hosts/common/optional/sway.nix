{pkgs, ...}: {
  security.polkit.enable = true;
  programs.dconf.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.stable.greetd.tuigreet}/bin/tuigreet --time --cmd "sway"
        '';
      };
    };
  };
}
