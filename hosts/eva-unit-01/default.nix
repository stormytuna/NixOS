{
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common/users/stormytuna.nix

    ../common/global

    ../common/optional/amd-graphics.nix
    ../common/optional/bluetooth.nix
    ../common/optional/gamescope.nix
    ../common/optional/pipewire.nix
    ../common/optional/steam.nix
    ../common/optional/thunar.nix
    ../common/optional/xpadneo.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.scripts
      outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "eva-unit-01";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # 25565 - Minecraft servers
      allowedTCPPorts = [25565];
      allowedUDPPorts = [25565];
    };
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  console.keyMap = "us";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
