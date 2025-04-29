{pkgs, ...}: {
  home.packages = [pkgs.libnotify]; # Nice to have on path

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = "(300, 500)";
        height = "(50, 200)";
        origin = "top-center";
        offset = "(0, 100)";
        transparency = 10;
        monitor = "DP-1"; # Left monitor
        corner_radius = 12;
        show_indicators = false;
      };

      # TODO: Change to negative comparison when https://github.com/dunst-project/dunst/issues/1040 is merged
      play_sound = let
        playSoundScript = pkgs.writeShellScript "dunst_playsound" ''
          ${pkgs.sox}/bin/play ${pkgs.modern-minimal-ui-sounds}/stereo/message-new-instant.oga
        '';
      in {
        appname = "*";
        script = playSoundScript.outPath;
      };
    };
  };
}
