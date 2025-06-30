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
      ExecStart = ''
        ${pkgs.fd}/bin/fd --unrestricted --type file --type directory --changed-before 7d --base-directory /home/stormytuna/downloads --exec print {} \+
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
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = 60;
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
