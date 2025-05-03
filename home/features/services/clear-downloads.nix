{
  pkgs,
  config,
  ...
}: {
  systemd.user.services.clear-downloads = {
    Unit = {
      Description = "Cleanup user downloads folder";
      After = ["network.target"];
    };

    Service = {
      Type = "oneshot";
      Environment = "HOME=${config.home.homeDirectory}";
      ExecStart = ''
        ${pkgs.findutils}/bin/find "$HOME/Downloads" -mtime +7 \\( -type f -o -type d \\) -delete
      '';
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };

  systemd.user.timers.clear-downloads = {
    Unit = {
      Description = "Cleaup user downloads folder timer";
    };

    Timer = {
      OnCalendar = "weekly";
      Persistent = true;
      RandomizedDelaySec = 60;
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
