{pkgs, ...}: {
  programs.dconf.enable = true; # Prevents nebulous homemanager errors with gtk

  # Required even though we configure via home manager
  programs.hyprland.enable = true;

  services.greetd = {
    enable = true;
    settings = rec {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
        user = "stormytuna";
      };
      initial_session = {
        command = "sway";
        user = "stormytuna";
      };
    };
  };
}
