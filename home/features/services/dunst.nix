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

        mouse_left_click = "do_action";
        mouse_middle_click = "none";
        mouse_right_click = "close_all";
      };

      # TODO: Change to negative comparison when https://github.com/dunst-project/dunst/issues/1040 is resolved
      play_sound = let
        playSoundScript = pkgs.writeShellScript "dunst_playsound" ''
          if [ "$DUNST_CATEGORY" == "SILENT" ]
          then
            exit 0
          fi

          if [ "$DUNST_URGENCY" == "CRITICAL" ]
          then
            ${pkgs.sox}/bin/play ${pkgs.modern-minimal-ui-sounds}/stereo/dialog-error-serious.oga
            exit 0
          fi

          case "$DUNST_APP_NAME" in
            "discord"|"vencord"|"vesktop")
              ${pkgs.sox}/bin/play ${pkgs.modern-minimal-ui-sounds}/stereo/message-new-instant.oga
              exit 0
          esac

          if [ "$DUNST_URGENCY" == "LOW" ]
          then
            ${pkgs.sox}/bin/play ${pkgs.modern-minimal-ui-sounds}/stereo/dialog-information.oga
            exit 0
          fi

          ${pkgs.sox}/bin/play ${pkgs.modern-minimal-ui-sounds}/stereo/completion-success.oga
        '';
      in {
        appname = "*";
        script = playSoundScript.outPath;
      };
    };
  };
}
