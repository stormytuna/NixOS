{
  lib,
  pkgs,
  inputs,
  ...
}: {
  services.foundryvtt = {
    enable = true;
    package = inputs.foundry-vtt.packages.${pkgs.stdenv.hostPlatform.system}.foundryvtt_13;
  };

# Stuff for v12, copied from https://github.com/reckenrode/nix-foundryvtt/blob/2f33b9bdd16230b7542adfad85bc168af1199639/modules/foundryvtt/default.nix
  systemd.services.foundryvtt12 = let 
    foundryV12Package = inputs.foundry-vtt.packages.${pkgs.stdenv.hostPlatform.system}.foundryvtt_12;
    foundryV12DataDir = "/var/lib/foundryvtt12";
    configFile = pkgs.writeText "options.json" ''
      {
        "hostname": "eva-unit-01",
        "language": "en.core",
        "port": 31000,
        "proxySSL": false,
        "routePrefix": null,
        "upnp": true,
        "dataPath": "/var/lib/foundryvtt12",
        "updateChannel": "stable",
        "awsConfig": null,
        "compressStatic": true,
        "compressSocket": true,
        "cssTheme": "dark",
        "deleteNEDB": false,
        "fullscreen": false,
        "hotReload": false,
        "localHostname": null,
        "passwordSalt": null,
        "proxyPort": null,
        "sslCert": null,
        "sslKey": null,
        "telemetry": true,
        "world": null,
        "serviceConfig": null
      }
    '';
  in {
    description = "Foundry Virtual Tabletop v12"; 
    documentation = [ "https://foundryvtt.com/kb/" ];

    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      User = "foundryvtt";
      Group = "foundryvtt";
      Restart = "always";
      ExecStart = "${lib.getBin foundryV12Package}/bin/foundryvtt --headless --noupdate --dataPath=\"${foundryV12DataDir}\"";
      StateDirectory = "foundryvtt";
      StateDirectoryMode = "0750";

      # Hardening
      CapabilityBoundingSet = [
        "AF_NETLINK"
        "AF_INET"
        "AF_INET6"
      ];
      DeviceAllow = [ "/dev/stdin r" ];
      DevicePolicy = "strict";
      IPAddressAllow = "localhost";
      LockPersonality = true;
      # MemoryDenyWriteExecute = true;
      NoNewPrivileges = true;
      PrivateDevices = true;
      PrivateTmp = true;
      PrivateUsers = true;
      ProtectClock = true;
      ProtectControlGroups = true;
      ProtectHome = true;
      ProtectHostname = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectSystem = "strict";
      ReadOnlyPaths = [ "/" ];
      RemoveIPC = true;
      RestrictAddressFamilies = [
        "AF_NETLINK"
        "AF_INET"
        "AF_INET6"
      ];
      RestrictNamespaces = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      SystemCallArchitectures = "native";
      SystemCallFilter = [
        "@system-service"
        "~@privileged"
        "~@resources"
        "@pkey"
      ];
      UMask = "0027";

      ReadWritePaths = [ foundryV12DataDir ];
    };

    preStart = ''
      installedConfigFile="${foundryV12DataDir}/Config/options.json"
      install -d -m750 ${foundryV12DataDir}/Config
      rm -f "$installedConfigFile" && install -m640 ${configFile} "$installedConfigFile"
    '';
  };
}
