{
  config,
  lib,
  ...
}: {
  options = {
    modules.apps.minecraft-server.enable = lib.mkEnableOption "Enables minecraft servers";
  };

  config = lib.mkIf config.modules.apps.minecraft-server.enable {
    services.minecraft-server = {
      enable = true;
      eula = true;
      openFirewall = true;

      declarative = true;
      serverProperties = {
        gamemode = "survival";
        difficulty = "normal";
        level-name = "I love my wife and her big beautiful breasts";
        motd = "Kill people with rocks, your God commands it";
        simulation-distance = 16;
        server-ip = "";
        server-port = 25565;
      };
    };

    systemd.services.minecraft-server.wantedBy = lib.mkForce []; # Prevent it from starting on load/update
  };
}
