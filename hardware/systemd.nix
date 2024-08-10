{ ... }:

{
  # nix.gc was throwing on rebuilds so just made systemd service
  systemd.services.cleanupgarbage = {
    enable = true;
    serviceConfig = {
      ExecStart = "nix-collect-garbage --delete-older-than 14d";
    };
  };
}
